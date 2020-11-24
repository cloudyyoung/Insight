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

--------------------------------------------------------------------------
--[[ Private Variables ]]
--------------------------------------------------------------------------
local TEXT_COLORING_ENABLED = GetModConfigData("text_coloring", true)
local Image = require("widgets/image")
local Text = require("widgets/text") --FIXED_TEXT
local Widget = require("widgets/widget")
local Reader = import("reader")

--------------------------------------------------------------------------
--[[ Private Functions ]]
--------------------------------------------------------------------------
local function _LookupIcon(icon) -- took me a minute but i remember that this is here for the prefabhasicon call 
	if true then
		PrefabHasIcon(icon)
	end
	
	return LookupIcon(icon)
end

local function InterpretReaderChunk(chunk, richtext) -- text, color
	local color = chunk:GetTag("color") or richtext.default_color

	if not TEXT_COLORING_ENABLED then
		color = "#FFFFFF"
	end

	color = Color.fromHex(color)

	local obj = nil

	if chunk:IsObject() then
		-- object
		if chunk.object.class == "icon" then
			local tex, atlas = _LookupIcon(chunk.object.value)
			if not atlas then
				--error("[insight]: attempt to lookup invalid icon: " .. tostring(chunk.object.value))
				--tex = "White_Square.tex"
				--atlas = "images/White_Square.xml"
				tex, atlas = _LookupIcon("blank")
			end
			obj = Image(atlas, tex)
			obj:SetSize(richtext.font_size - 2, richtext.font_size - 2) -- 30, 30 a bit too large
			obj:SetTint(unpack(color))
		else
			error("[Insight]: unrecognized object class: " .. tostring(chunk.object.class))
		end
	else
		-- text
		obj = Text(richtext.font, richtext.font_size, chunk.text)
		obj:SetColour(color)

		if chunk:HasTag("u") then
			local w, h = obj:GetRegionSize()
			local underline = obj:AddChild(Image("images/White_Square.xml", "White_Square.tex"))
			underline:SetTint(color.r, color.g, color.b, color.a)
			underline:SetSize(w - 2, 2)
			underline:SetPosition(-4, -15 + 3)
			underline:MoveToBack()
		end
	end

	return obj
end

--------------------------------------------------------------------------
--[[ RichText ]]
--------------------------------------------------------------------------
local RichText = Class(Widget, function(self, font, size, text, colour)
	Widget._ctor(self, "RichText")

	self.lines = {}

	self.font = UIFONT
	self.font_size = 30
	self.raw_text = nil
	self.default_color = "#ffffff"

	if font then
		self:SetFont(font)
	end

	if size then
		self:SetSize(30)
	end
	
	if text then
		self:SetString(text)
	end

	if colour then
		self:SetColour(colour)
	end
end)

function RichText:GetColour()
	return Color.fromHex(self.default_color)
end

function RichText:SetColour(clr) -- Text::SetColour
	if type(clr) == "string" then
		assert(Color.IsValidHex(clr), "RichText:SetColour with invalid hex")
	end

	self.default_color = clr:ToHex()
end

function RichText:GetFont()
	return self.font
end

function RichText:SetFont(font)
	self.font = font
	self:SetString(self:GetString(), true)
end

function RichText:SetSize(num)
	assert(type(num) == "number", "RichText:SetSize expected arg #1 to be number")
	
	if self.font_size == num then
		return
	end

	self.font_size = num
	self:SetString(self:GetString(), true)
end

function RichText:GetString()
	return self.raw_text
end

function RichText:SetString(str, forced)
	if not forced and self.raw_text == str then
		-- why change?
		return
	end
	
	self.raw_text = str
	self:KillAllChildren()
	self.lines = {}

	--[[
	local m = self:AddChild(Image("images/White_Square.xml", "White_Square.tex"))
	local t = self:AddChild(Text(UIFONT, 30, "please work good"))
	m:SetSize(t:GetRegionSize())
	t:SetPosition(4, -1)
	--]]

	--[[
	local m = self:AddChild(Image("images/White_Square.xml", "White_Square.tex"))
	local t = self:AddChild(Text(UIFONT, 30, "饥饿速度降低: yep"))
	m:SetSize(t:GetRegionSize())
	t:SetPosition(4, -1)
	--]]

	if str == nil then
		return
	end

	
	local lines = {}

	for line in string.gmatch(str, "([^\n]+)\n*") do
		table.insert(lines, Reader:new(line):Read())
	end

	for _, l in pairs(lines) do
		self:NewLine(l)
	end
	
end

function RichText:GetRegionSize()
	local width, height = 0, 0

	for i,v in pairs(self.lines) do
		height = height + v.height
		if v.width > width then
			width = v.width
		end
	end

	return width, height
end

function RichText:SetRegionSize()
	error("RichText does not support SetRegionSize.")
end

function RichText:ResetRegionSize()
	error("RichText does not support ResetRegionSize.")
end

-- ok time for the good stuf
function RichText:NewLine(pieces)
	local container = self:AddChild(Widget("container" .. #self.lines + 1))
	table.insert(self.lines, container)

	-- create text objects
	local texts = {}
	for _, piece in pairs(pieces) do
		table.insert(texts, container:AddChild(InterpretReaderChunk(piece, self)))
	end

	local padding = 0

	-- position them
	for i, obj in pairs(texts) do
		local prev = texts[i-1]
		local lp = 0
		local x = 0
		local y = (obj.name == "Image" and 2) or 0 -- -1

		-- REGION SIZES AREN'T EXACT AND SPACES VARY IN WIDTH DEPENDING ON POSITION IN SetString
		-- I SPENT HOURS WONDERING WHAT WAS GOING ON
		-- MY FURY KNOWS NO BOUNDS
		-- THEN I SPENT MORE HOURS FIXING MY WRONG MATH
		-- I really don't get the inconsistency. It's so incredibly frustrating.
		-- And to rub salt in a wound, text objects aren't even aligned within their own damn object.

		--[[ [dst]
			1.6 width if space comes at end
			space by itself is 4.2
		 	two spaces is 9.6
		 	three spaces is 15.0
		]]

		--[[ [ds]
			variable width if space comes at end
			space by itself is 7.8
			two spaces is 13.2
			three spaces is 18.6
		]]


		if prev then
			lp = prev:GetPosition().x

			local end_spaces = 0
			if prev.name == "Image" then
				lp = lp + prev:GetSize() / 2
				
			else
				lp = lp + prev:GetRegionSize() / 2

				if IsDST() then
					lp = lp - 2
					padding = padding + 2
				end

				end_spaces = #string.match(prev:GetString(), "(%s*)$")
			end
			

			if obj.name == "Image" then
				lp = lp + obj:GetSize() / 2
			else
				lp = lp + obj:GetRegionSize() / 2

				if IsDS() and prev.name ~= "Image" then
					lp = lp - 3.9
					padding = padding + 3.9
				end
			end

			if end_spaces > 0 then
				--lp = lp - 1.6
				--padding = padding + 1.6

				if IsDST() then
					-- commented when was fiddling with icon mode
					--lp = lp - 1.6 -- space width at end
					--padding = padding + 1.6

					--lp = lp + CalculateSize(string.rep(" ", end_spaces)) - 0.8
					--padding = padding - CalculateSize(string.rep(" ", end_spaces)) + 0.8

					-- this solution works for both text and icons, sweet
					lp = lp + CalculateSize(string.rep(" ", end_spaces)) / 2
					padding = padding - CalculateSize(string.rep(" ", end_spaces)) / 2
				end
			end


			--[[
			lp = prev:GetPosition().x
			
			lp = lp + prev:GetRegionSize() / 2

			lp = lp - 2
			padding = padding + 2

			lp = lp + obj:GetRegionSize() / 2

			local end_spaces = #string.match(prev:GetString(), "(%s*)$")

			if end_spaces > 0 then
				lp = lp - 1.6 
				padding = padding + 1.6
				lp = lp + CalculateSize(string.rep(" ", end_spaces)) - 0.8
				padding = padding - CalculateSize(string.rep(" ", end_spaces)) + 0.8
			end
			--]]

			--[[
			if prev.name == "Image" then
				x = prev:GetSize() / 2
			else
				x = prev:GetRegionSize() / 2
				x = x - 2
				padding = padding + 2
			end

			if obj.name == "Image" then
				x = x + obj:GetSize() / 2
			else
				x = x + obj:GetRegionSize() / 2
				x = x - 2
				padding = padding + 2
			end
			--]]
		end

		--[[
		if prev then
			lp = prev:GetPosition().x

			if prev.name == "Image" then
				x = prev:GetSize() / 2
			else
				x = prev:GetRegionSize() / 2
			end

			if obj.name == "Image" then
				x = x + obj:GetSize() / 2
			else
				x = x + obj:GetRegionSize() / 2
			end

			
			if prev.name == "Text" then
				local a = prev:GetString():sub(#prev:GetString())
				local x1 = CalculateSize(a)

				if true then
					local r = x1 / 2 --6.5

					if a == " " then
						r = r / 2
					else
						r = r - 0.5
					end

					padding = padding + r

					x = x - r
				
				end
			end
			
		end
		--]]
		
		obj:SetPosition(lp + x, y)
	end

	local width = 0

	for i,v in pairs(texts) do
		if i > 1 then
			
			local w = (v.name == "Image" and v:GetSize()) or v:GetRegionSize()
			width = width - w / 2
			

			--width = width - v:GetRegionSize() / 2 - 2
		end
	end

	width = width + padding / 2

	--[[
		str = "Sanity: +4.4/min"
		two orange pieces: "Sanity" and "+4.4/min"
		1. width of "+4.4/min" is 80.4
		2. the first piece is always irrelevant, its pos is set to 0
		3. -80.4 overshoots left
		4. -40.2 (aka half of that) is nearly a perfect even besides irritable spacing at ends
		5. so we can assume the relevant offsets come from every width/2 after the first one
		6. doing that has a "perfect" middle balance, ignoring end spacing
		7. we know that spacing is accounted for above
		8. and since we had to halve the width because of position logic, we need to halve that spacing as well
		9. it. is. done. I have spent over 8 hours on this spacing.
		10. never been good at uis.
	]]

	container:SetPosition(
		--cc:GetPosition().x / 2, 
		width, 
		-self.font_size * (#self.lines - 1)
	)
	
	local wax = 0
	for i,v in pairs(texts) do
		local w = (v.name == "Image" and v:GetSize()) or v:GetRegionSize()
		wax = wax + w
	end

	--[[
	local a, b = CalculateSize(self:GetString())
	print("COMPARISON", self:GetString(), "-> width: ", width, "|wax:", wax, "| diff:", wax-padding/2, "Watson:", a, "| fat:", fat)
	--]]



	--print(fat, width, math.abs(width) * 2)
	
	-- size me up
	--container:SetSize(width, 30)
	container.width = wax --math.abs(width) * 2
	container.height = self.font_size 

	return container
end

function RichText:__tostring()
	return string.format("%s - %s", self.name, self.raw_text or "<null>")
end


return RichText