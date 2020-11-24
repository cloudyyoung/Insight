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

-- harvestable.lua
local COLORS = {
	honey = Insight.COLORS.SWEETENER,
	red_cap = "#A64E47",
	green_cap = "#446B4A",
	blue_cap = "#719BA5",
}

local function Describe(self, context)
	local description = nil

	if not self.product then
		return
	end

	if context.usingIcons and PrefabHasIcon(self.product) then
		description = string.format(context.lstr.harvestable.product, self.product, self.produce, self.maxproduce)
	else
		local name = STRINGS.NAMES[self.product:upper()] or ("\"" .. self.product .. "\"")
		name = string.format("<color=%s>%s</color>", COLORS[self.product] or "#ffffff", name)

		description = string.format(context.lstr.lang.harvestable.product, name, self.produce, self.maxproduce)

		if self.targettime then
			description = CombineLines(description, string.format(context.lstr.harvestable.grow, TimeToText(time.new(self.targettime - GetTime(), context))))
		end
	end

	return {
		priority = 0,
		description = description
	}
end



return {
	Describe = Describe
}