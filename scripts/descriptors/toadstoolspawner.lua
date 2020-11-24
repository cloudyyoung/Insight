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

-- toadstoolspawner.lua [Worldly]
local function GetToadstoolData(self)
	local time_to_respawn = (self:OnSave() or {}).timetorespawn

	return {
		time_to_respawn = time_to_respawn
	}
end

local function Describe(self, context)
	local description = nil
	local data = nil

	if self == nil and context.toadstool_data then
		data = context.toadstool_data
	elseif self and context.toadstool_data == nil then
		data = GetToadstoolData(self)
	else
		error(string.format("deerclopsspawner.Describe improperly called with self=%s & toadstool_data=%s", tostring(self), tostring(context.toadstool_data)))
	end
	
	if data.time_to_respawn then
		description = TimeToText(time.new(data.time_to_respawn, context))
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Toadstool.xml",
			tex = "Toadstool.tex",
		},
		worldly = true
	}
end



return {
	Describe = Describe,
	GetToadstoolData = GetToadstoolData,
}