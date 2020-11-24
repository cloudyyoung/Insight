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

-- me

return {
	-- insightservercrash.lua
	server_crash = "This server has crashed. The cause is unknown.",
	
	-- modmain.lua
	dragonfly_ready = "Ready to fight.",

	-- time.lua
	time_segments = "%s segment(s)",
	time_days = "%s day(s), ",
	time_days_short = "%s day(s)",
	time_seconds = "%s second(s)",
	time_minutes = "%s minute(s), ",
	time_hours = "%s hour(s), ",

	-------------------------------------------------------------------------------------------------------------------------

	-- appeasement.lua
	appease_good = "Delays eruption by %s segment(s).",
	appease_bad = "Hastens eruption by %s segment(s).",

	-- armor.lua
	protection = "<color=HEALTH>Protection</color>: <color=HEALTH>%s%%</color>",
	durability = "<color=#C0C0C0>Durability</color>: <color=#C0C0C0>%s</color> / <color=#C0C0C0>%s</color>",

	-- beargerspawner.lua
	incoming_bearger_targeted = "<color=%s>Target: %s</color> -> %s",

	-- boathealth.lua
	-- use 'health' from 'health'

	-- breeder.lua
	breeder_tropical_fish = "<color=#64B08C>Tropical Fish</color>",
	--breeder_fish2 = "Tropical Wanda", --in code but unused
	breeder_fish3 = "<color=#6C5186>Purple Grouper</color>",
	breeder_fish4 = "<color=#DED15E>Pierrot Fish</color>",
	breeder_fish5 = "<color=#9ADFDE>Neon Quattro</color>",
	breeder_fishstring = "%s: %s / %s",
	breeder_nextfishtime = "Additional fish in: %s",
	breeder_possiblepredatortime = "May spawn a predator in: %s",

	-- chessnavy.lua
	chessnavy_timer = "%s",
	chessnavy_ready = "Waiting for you to return to a crime scene.",

	-- combat.lua
	damage = "<color=HEALTH>Damage</color>: <color=HEALTH>%s</color>",
	damageToYou = " (<color=HEALTH>%s</color> to you)",

	-- cooldown.lua
	cooldown = "Cooldown: %s",

	-- crabkingspawner.lua
	crabking_spawnsin = "%s",

	-- crittertraits.lua
	dominant_trait = "Dominant trait: %s",

	-- crop.lua
	crop_paused = "Paused.",
	growth = "<color=NATURE>%s</color>: <color=NATURE>%s</color>",

	-- dapperness.lua
	dapperness = "<color=SANITY>Sanity</color>: <color=SANITY>%s/min</color>",

	-- debuffable.lua
	buff_text = "<color=MAGIC>Buff</color>: %s, %s",

	-- deerclopsspawner.lua
	incoming_deerclops_targeted = "<color=%s>Target: %s</color> -> %s",

	-- diseaseable.lua
	disease_in = "Will become diseased in: %s",
	disease_spread = "Will spread disease in: %s",
	disease_delay = "Disease is delayed for: %s",

	-- domesticable.lua
	domestication = "Domestication: %s%%",
	obedience = "Obedience: %s%%",

	-- drivable.lua

	-- dryer.lua
	dryer_paused = "Drying paused.",
	dry_time = "Remaining time: %s",

	-- edible.lua
	food_unit = "<color=%s>%s</color> unit(s) of <color=%s>%s</color>", 
	edible_interface = "<color=HUNGER>Hunger</color>: <color=HUNGER>%s</color> / <color=SANITY>Sanity</color>: <color=SANITY>%s</color> / <color=HEALTH>Health</color>: <color=HEALTH>%s</color>",
	edible_wiki = "<color=HEALTH>Health</color>: <color=HEALTH>%s</color> / <color=HUNGER>Hunger</color>: <color=HUNGER>%s</color> / <color=SANITY>Sanity</color>: <color=SANITY>%s</color>",
	edible_foodtype = {
		meat = "meat",
		monster = "monster",
		fish = "fish",
		veggie = "veggie",
		fruit = "fruit",
		egg = "egg",
		sweetener = "sweetener",
		frozen = "frozen",
		fat = "fat",
		dairy = "dairy",
		decoration = "decoration",
		magic = "magic",
		precook = "precook",
		dried = "dried",
		inedible = "inedible",
		bug = "bug",
		seed = "seed",
	},
	edible_foodeffect = {
		temperature = "Temperature: %s, %s",
		caffeine = "Speed: %s, %s",
		surf = "Ship Speed: %s, %s",
		autodry = "Drying Bonus: %s, %s",
		instant_temperature = "Temperature: %s, (Instant)",
		antihistamine = "Hayfever Delay: %ss",
	},
	foodmemory = "Recently eaten: %s / %s, will forget in: %s",

	-- equippable.lua
	-- use 'dapperness' from 'dapperness'
	speed = "<color=DAIRY>Speed</color>: %s%%",
	hunger_slow = "<color=HUNGER>Hunger slow</color>: <color=HUNGER>%s%%</color>",

	-- example.lua
	why = "[why am i empty]",

	-- explosive.lua
	explosive_damage = "<color=LIGHT>Explosion Damage</color>: %s",
	explosive_range = "<color=LIGHT>Explosion Range</color>: %s",

	-- fertilizer.lua
	growth_value = "Shortens <color=NATURE>growth time</color> by <color=NATURE>%s</color> seconds.",

	-- finiteuses.lua
	action_uses = "<color=#aaaaee>%s</color>: %s",
	action_sleepin = "Sleep",
	action_fan = "Fan",
	action_play = "Play", -- beefalo horn
	action_hammer = "Hammer",
	action_chop = "Chop",
	action_mine = "Mine",
	action_net = "Catch",
	action_hack = "Hack", -- sw
	action_terraform = "Terraform",
	action_dig = "Dig",
	action_brush = "Brush",
	action_gas = "Gas", -- hamlet
	action_disarm = "Disarm", -- hamlet
	action_pan = "Pan", -- hamlet
	action_dislodge = "Chisel", -- hamlet
	action_spy = "Investigate", -- hamlet
	action_throw = "Throw", -- sw -- Action string is "Throw At"
	action_unsaddle = "Unsaddle",
	action_shear = "Shear",
	action_attack = "Attack",
	action_fish = "Fish",
	action_row = "Row",
	action_row_fail = "Failed row",

	-- fishable.lua
	fish_count = "<color=SHALLOWS>Fish</color>: <color=WET>%s</color> / <color=WET>%s</color>",
	fish_recharge = ": +1 fish in: %s",

	-- fishingrod.lua
	fishingrod_waittimes = "Wait time: <color=SHALLOWS>%s</color> - <color=SHALLOWS>%s</color>",

	-- follower.lua
	leader = "Leader: %s",
	loyalty_duration = "Loyalty duration: %s",
	ghostlybond = "Sisterly bond: %s / %s. +1 in %s.",
	ghostlybond_self = "Your sisterly bond: %s / %s. +1 in %s.",

	-- friendlevels.lua
	friendlevel = "Friendliness level: %s / %s",

	-- fuel.lua
	fuel = "<color=LIGHT>%s</color> second(s) of fuel.",
	fuel_verbose = "<color=LIGHT>%s</color> second(s) of <color=LIGHT>'%s'</color>.",

	-- fueled.lua
	fueled_time = "<color=LIGHT>Fuel</color> remaining (<color=LIGHT>%s%%</color>): %s", -- percent, time
	fueled_time_verbose = "<color=LIGHT>%s</color> remaining (<color=LIGHT>%s%%</color>): %s", -- type, percent, time
	fuel_efficiency = "<color=LIGHT>Fuel efficiency</color>: <color=LIGHT>%s%%</color>",

	-- growable.lua
	growth_stage = "Stage '%s': %s / %s: ",
	growth_paused = "Growth paused.",
	growth_next_stage = "Next stage in %s.",

	-- grower.lua
	harvests = "<color=NATURE>Harvests</color>: <color=NATURE>%s</color> / <color=NATURE>%s</color>",

	-- hackable.lua
	-- use 'regrowth' from 'pickable'
	-- use 'regrowth_paused' from 'pickable'

	-- harvestable.lua
	harvestable = {
		product = "%s: %s / %s",
		grow = "+1 in %s.",
	},

	-- hatchable.lua
	hatchable = {
		discomfort = "Discomfort: %s / %s",
		progress = "Hatching progress: %s / %s",
	},

	-- healer.lua
	heal = "Health: %+d",

	-- health.lua
	health = "<color=HEALTH>Health</color>: <<color=HEALTH>%s</color> / <color=HEALTH>%s</color>>",
	health_regeneration = " (<color=HEALTH>+%s</color> / <color=HEALTH>%ss</color>)",
	absorption = " : Absorbing %s%% of damage.",
	naughtiness = "Naughtiness: %s",
	player_naughtiness = "Your naughtiness: %s / %s",

	-- herdmember.lua
	herd_size = "Herd size: %s / %s",

	-- hunger.lua
	hunger = "<color=HUNGER>Hunger</color>: <color=HUNGER>%s</color> / <color=HUNGER>%s</color>",
	hunger_burn = "<color=HUNGER>Hunger decay</color>: <color=HUNGER>%+d/day</color> (<color=HUNGER>%s/s</color>)",
	hunger_paused = "<color=HUNGER>Hunger</color> decay paused.",

	-- inspectable.lua
	hunt_progress = "Track: %s / %s",
	global_wetness = "<color=FROZEN>Global Wetness</color>: <color=FROZEN>%s</color>",
	precipitation_rate = "<color=WET>Precipitation Rate</color>: <color=WET>%s</color>",
	frog_rain_chance = "<color=FROG>Frog rain chance</color>: <color=FROG>%s%%</color>",
	world_temperature = "<color=LIGHT>World Temperature</color>: <color=LIGHT>%s</color>",
	unlocks = "Unlocks: %s",

	-- insulator.lua
	insulation_winter = "<color=FROZEN>Insulation (Winter)</color>: <color=FROZEN>%s</color>",
	insulation_summer = "<color=FROZEN>Insulation (Summer)</color>: <color=FROZEN>%s</color>",

	-- klaussackspawner.lua
	klaussack_spawnsin = "%s",
	klaussack_despawn = "Despawns on day: %s",

	-- leader.lua
	followers = "Followers: %s",

	-- malbatrossspawner.lua
	malbatross_spawnsin = "%s",
	malbatross_waiting = "Waiting for someone to go to a shoal.",

	-- mast.lua
	mast_sail_force = "Sail force: %s",
	mast_max_velocity = "Max velocity: %s",

	-- mermcandidate.lua
	mermcandidate = "Calories: %s / %s",

	-- moisture.lua
	moisture = "<color=WET>Wetness</color>: <color=WET>%s%%</color>", --moisture = "<color=WET>Wetness</color>: %s / %s (%s%%)",

	-- nightmareclock.lua
	nightmareclock = "<color=%s>Phase: %s</color>, %s",
	nightmareclock_lock = "Locked by the <color=#CE3D45>Ancient Key</color>.",

	-- oar.lua
	oar_force = "<color=INEDIBLE>Force</color>: <color=INEDIBLE>%s%%</color>",

	-- periodicthreat.lua
	worms_incoming = "%s",
	worms_incoming_danger = "<color=HEALTH>%s</color>",

	-- perishable.lua
	rot = "Rots",
	stale = "Stale",
	spoil = "Spoils",
	dies = "Dies",
	perishable_transition = "<color=MONSTER>%s</color> in: %s",
	perishable_paused = "Currently not decaying.",

	-- petrifiable.lua
	petrify = "Will become petrified in %s.",

	-- pickable.lua
	regrowth = "<color=NATURE>Regrows</color> in: <color=NATURE>%s</color>",
	regrowth_paused = "Regrowth paused.",
	pickable_cycles = "<color=DECORATION>Remaining harvests</color>: <color=DECORATION>%s</color> / <color=DECORATION>%s</color>",

	-- pollinator.lua
	pollination = "Flowers pollinated: (%s) / %s",

	-- preservative.lua
	preservative = "Restores %s%% of freshness.",

	-- quaker.lua
	next_quake = "<color=INEDIBLE>Earthquake</color> in %s",

	-- questowner.lua
	questowner = {
		pipspook = {
			toys_remaining = "Toys remaining: %s",
			assisted_by = "This pipspook is being assisted by %s.",
		},
	},

	-- sanity.lua
	sanity = "<color=SANITY>Sanity</color>: <color=SANITY>%s</color> / <color=SANITY>%s</color> (<color=SANITY>%s%%</color>)",
	enlightenment = "<color=ENLIGHTENMENT>Enlightenment</color>: <color=ENLIGHTENMENT>%s</color> / <color=ENLIGHTENMENT>%s</color> (<color=ENLIGHTENMENT>%s%%</color>)",

	-- sanityaura.lua
	sanityaura = "<color=SANITY>Sanity Aura</color>: <color=SANITY>%s/min</color>",

	-- sinkholespawner.lua
	antlion_rage = "%s",

	-- soul.lua
	wortox_soul_heal = "<color=HEALTH>Heals</color> for <color=HEALTH>13</color> - <color=HEALTH>20</color>.",

	-- spawner.lua
	spawner_next = "Will spawn a %s in %s.",

	-- stewer.lua
	cooktime_remaining = "<color=HUNGER>%s</color>(<color=HUNGER>%s</color>) will be done in %s second(s).",
	cooker = "Cooked by <color=%s>%s</color>.",
	cooktime_modifier_slower = "Cooks food <color=#DED15E>%s%%</color> slower.",
	cooktime_modifier_faster = "Cooks food <color=NATURE>%s%%</color> faster.",

	-- stickable.lua
	stickable = "<color=FISH>Mussels</color>: %s",

	-- temperature.lua
	temperature = "Temperature: %s",

	-- tigersharker.lua
	tigershark_spawnin = "Can spawn in: %s",
	tigershark_waiting = "Ready to spawn.",
	tigershark_exists = "Tiger shark is present.",

	-- timer.lua
	timer_paused = "Paused",
	timer = "Timer '%s': %s",

	-- tool.lua
	action_efficiency = "<color=#DED15E>%s</color>: %s%%",
	tool_efficiency = "<color=NATURE>Efficiency</color> < %s >", -- #A5CEAD

	-- tradable.lua
	tradable_gold = "Worth %s gold nugget(s).",
	tradable_gold_dubloons = "Worth %s gold nugget(s) and %s dubloon(s).",
	tradable_rocktribute = "Delays <color=LIGHT>Antlion</color> rage by %s day(s).",

	-- unwrappable.lua
	-- handled by klei?

	-- upgradeable.lua
	upgradeable_stage = "Stage %s / %s: ",
	upgradeable_complete = "Upgrade %s%% complete.",
	upgradeable_incomplete = "No upgrades possible.",

	-- waterproofer.lua
	waterproofness = "<color=WET>Waterproofness</color>: <color=WET>%s%%</color>",

	-- weapon.lua
	weapon_damage_type = {
		normal = "<color=HEALTH>Damage</color>",
		electric = "<color=WET>Electric</color> <color=HEALTH>Damage</color>",
		poisonous = "<color=NATURE>(Poisonous)</color> <color=HEALTH>Damage</color>",
		thorns = "<color=HEALTH>(Thorns)</color> <color=HEALTH>Damage</color>"
	},
	weapon_damage = "%s: <color=HEALTH>%s</color>",
	attack_range = "Range: %s",

	-- wereness
	wereness_remaining = "Wereness: %s / %s",

	-- witherable.lua
	witherable = {
		delay = "State change is delayed for %s",
		wither = "Will wither in %s",
		rejuvenate = "Will rejuvenate in %s"
	}
}