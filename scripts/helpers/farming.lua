--[[
Copyright (C) 2020 penguin0616

This file is part of Insight.

The source code of this program is shared under the RECEX
SHARED SOURCE LICENSE (version 1.0).
The source code is shared for referrence and academic purposes
with the hope that people can read and learn from it. This is not
Free and Open Source software, and code is not redistributable
without permission of the author. Read the RECEX SHARED
SOURCE LICENSE for details
The source codes does not come with any warranty including
the implied warranty of merchandise.
You should have received a copy of the RECEX SHARED SOURCE
LICENSE in the form of a LICENSE file in the root of the source
directory. If not, please refer to
<https://raw.githubusercontent.com/Recex/Licenses/master/SharedSourceLicense/LICENSE.txt>
]]

-- This file is responsible for providing some common values where farming is concerned.
--------------------------------------------------------------------------
--[[ Private Variables ]]
--------------------------------------------------------------------------
local _string, xpcall, package, tostring, print, os, unpack, require, getfenv, setmetatable, next, assert, tonumber, io, rawequal, collectgarbage, getmetatable, module, rawset, math, debug, pcall, table, newproxy, type, coroutine, _G, select, gcinfo, pairs, rawget, loadstring, ipairs, _VERSION, dofile, setfenv, load, error, loadfile = string, xpcall, package, tostring, print, os, unpack, require, getfenv, setmetatable, next, assert, tonumber, io, rawequal, collectgarbage, getmetatable, module, rawset, math, debug, pcall, table, newproxy, type, coroutine, _G, select, gcinfo, pairs, rawget, loadstring, ipairs, _VERSION, dofile, setfenv, load, error, loadfile

local SOIL_RAIN_MOD = TUNING.SOIL_RAIN_MOD
local MIN_DRYING_TEMP = TUNING.SOIL_MIN_DRYING_TEMP
local MAX_DRYING_TEMP = TUNING.SOIL_MAX_DRYING_TEMP
local SOIL_MIN_TEMP_DRY_RATE = TUNING.SOIL_MIN_TEMP_DRY_RATE
local SOIL_MAX_TEMP_DRY_RATE = TUNING.SOIL_MAX_TEMP_DRY_RATE
local MAX_SOIL_MOISTURE = TUNING.SOIL_MAX_MOISTURE_VALUE

local FERTILIZER_DEFS = (IsDST() and CurrentRelease.GreaterOrEqualTo("R14_FARMING_REAPWHATYOUSOW") and require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS) or {}
local PLANT_DEFS = (IsDST() and CurrentRelease.GreaterOrEqualTo("R14_FARMING_REAPWHATYOUSOW") and require("prefabs/farm_plant_defs").PLANT_DEFS) or {}

local farming_manager = nil
local growers = {}
local lib = nil

--------------------------------------------------------------------------
--[[ Private Functions ]]
--------------------------------------------------------------------------
local GetTileDataAtPoint = nil --[[
	belowsoiltile	7	
	soil_drinkers	table: 4D9E3B20	
	nutrients_overlay	100038 - nutrients_overlay	
	nutrients	2236454	
	soilmoisture	90.558837890625	
]]

--- Check if we are initialized or not
local function IsInitialized()
	return farming_manager ~= nil
end

--- Hook
local function Initialize(self)
	farming_manager = self
	GetTileDataAtPoint = util.getupvalue(self.IsSoilMoistAtPoint, "GetTileDataAtPoint")
	lib.GetTileDataAtPoint = GetTileDataAtPoint
	mprint("Farming_Manager has been hooked")
end

--- backwards compatibility yaaaaaaaaaaaaaaaaaaaaaaaay
local function RegisterOldGrower(grower)
	if not grower.inst:IsValid() then
		return
	end

	if table.contains(growers, grower.inst) then
		return
	end

	table.insert(growers, grower.inst)
	
	grower.inst:ListenForEvent("onremove", function(inst)
		local index = table.reverselookup(growers, inst)
		if index then
			table.remove(growers, index)
		end
	end)
end

--- Old farming system is being used
local function WorldHasOldGrowers()
	return #growers > 0
end

--- Gets tile moisture at point
local function GetTileMoistureAtPoint(x, y, z)
	return GetTileDataAtPoint(false, x, y, z).soilmoisture
end

--- Returns the current world moisture rate.
local function GetWorldMoistureDelta()
	local rain_rate = TheWorld.state.israining and TheWorld.state.precipitationrate or 0
	--local world_wetness = TheWorld.state.wetness
	local world_temp = TheWorld.state.temperature
	local world_rate = rain_rate > 0 and (rain_rate * SOIL_RAIN_MOD) or Remap(Clamp(world_temp, MIN_DRYING_TEMP, MAX_DRYING_TEMP), MIN_DRYING_TEMP, MAX_DRYING_TEMP, SOIL_MIN_TEMP_DRY_RATE, SOIL_MAX_TEMP_DRY_RATE)

	return world_rate
end

--- Returns the total rate of all the soil drinkers.
local function GetTileMoistureDelta(x, y, z)
	local tile_data = GetTileDataAtPoint(false, x, y, z)
	
	local obj_rate = 0
	if tile_data.soil_drinkers ~= nil then
		for obj, _ in pairs(tile_data.soil_drinkers) do
			obj_rate = obj_rate + obj.components.farmsoildrinker:GetMoistureRate()
		end
	end

	return obj_rate
end

--- Gets fertilizer nutrient value for prefab
local function GetNutrientValue(prefab)
	for _prefab, data in pairs(FERTILIZER_DEFS) do
		if _prefab == prefab then
			return data.nutrients
		end
	end
end

--- Get tile nutrients at point
local function GetTileNutrientsAtPoint(x, y, z)
	--local tile_data = GetTileDataAtPoint(false, x, y, z);
	-- farming_manager:GetTileNutrients

	local x, y = TheWorld.Map:GetTileCoordsAtPoint(x, y, z)
	local nutrients = {TheWorld.components.farming_manager:GetTileNutrients(x, y)}

	-- NUTRIENT_1 = "Growth Formula",
	-- NUTRIENT_2 = "Compost",
	-- NUTRIENT_3 = "Manure",
	
	--[[
		local nutrientlevels = inst.nutrientlevels:value()
		local nutrients = {
			bit.band(nutrientlevels, 7),
			bit.band(bit.rshift(nutrientlevels, 3), 7),
			bit.band(bit.rshift(nutrientlevels, 6), 7),
		}
		for num, nutrient in ipairs(nutrients) do
			local nutrient_name = nutrient_prefix..tostring(num)
	]]

	return {
		formula = nutrients[1],
		compost = nutrients[2],
		manure = nutrients[3]
	}
end

--- Returns plant's nutrient modifiers for the tile 
local function GetPlantNutrientModifier(plant_def)
	local consume = plant_def.nutrient_consumption
	local restore = plant_def.nutrient_restoration

	local nutrient_modifier = {0, 0, 0} -- base nutrients 

	local total_restore_count = 0
	-- farming_manager, in the ipairs(consume) loop, treats consumptioncount as the lower of the tile's nutrient type or the actual amount
	-- this is because it doesn't make sense to restore nutrients for less
	-- however, we don't care because we don't take the real-world (ha) restoration into account, we care about the theoretical restoration
	-- that means that total_restore_count should just be the added up consumed nutrients


	-- now i don't like using ipairs, since it's slower than pairs, but i doubt we'll have more than 3 nutrients
	-- i am tempted to just ``for i = 1, 3 do`` but who knows, maybe plants are rigged to consume more nutrients for some reason.
	for nutrient_type, amount in ipairs(consume) do
		nutrient_modifier[nutrient_type] = nutrient_modifier[nutrient_type] + -amount
		total_restore_count = total_restore_count + amount
	end

	-- this math is taken from Farming_Manager's CycleNutrientsAtPoint
	if restore then
	   --amount of valid nutrient types to restore
	 	local nutrients_to_restore_count = GetTableSize(restore)
		--the amount of nutrients to restore to all nutrients in the restore table
		local nutrient_restore_count = math.floor(total_restore_count/nutrients_to_restore_count) -- 8/3 = 2.66666 = 2

		--if the number doesn't divide evenly between the nutrients, randomly restore the excess nutrients to a valid type
		local excess_restore_count = total_restore_count - (nutrient_restore_count * nutrients_to_restore_count) -- 8 - (2 * 3) = 2
		--if excess_restore_count is 0 we do nothing
		--if excess_restore_count is 1, we add it to the nutrient determined by math.random
		--if excess_restore_count is 2, we add it to all other nutrients except the one determined by math.random
		--due to our total nutrient count, excess_restore_count will always come to be a valid number
		local excess_restore_rand = math.random(nutrients_to_restore_count)

		for n_type = 1, 3 do
			if restore[n_type] then
				nutrient_modifier[n_type] = nutrient_modifier[n_type] + nutrient_restore_count

				excess_restore_rand = excess_restore_rand - 1
				if (excess_restore_count == 1 and excess_restore_rand == 0) or (excess_restore_count == 2 and excess_restore_rand ~= 0) then
					nutrient_modifier[n_type] = nutrient_modifier[n_type] + 1
				end
			end
		end
	end

	return {
		formula = nutrient_modifier[1],
		compost = nutrient_modifier[2],
		manure = nutrient_modifier[3],
	}
end

--- Returns plant product
local function GetPlantProduct(plant) -- farm_plant_...
	for veggie, data in pairs(PLANT_DEFS) do
		if data.prefab == plant then
			return veggie
		end
	end
end

lib = {
	IsInitialized = IsInitialized,
	Initialize = Initialize,
	RegisterOldGrower = RegisterOldGrower,
	WorldHasOldGrowers = WorldHasOldGrowers,

	GetTileDataAtPoint = GetTileDataAtPoint,
	GetTileMoistureAtPoint = GetTileMoistureAtPoint,
	GetWorldMoistureDelta = GetWorldMoistureDelta,
	GetTileMoistureDelta = GetTileMoistureDelta,

	GetNutrientValue = GetNutrientValue,
	GetTileNutrientsAtPoint = GetTileNutrientsAtPoint,
	GetPlantNutrientModifier = GetPlantNutrientModifier,

	GetPlantProduct = GetPlantProduct,
}

return setmetatable({}, {__index = lib})