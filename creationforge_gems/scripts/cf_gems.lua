-- cf_gems.lua — Creation Forge add-on: Fantasy Gems.
--
-- Adds custom gemstones DF vanilla lacks (starstone, soulgem, dragon-eye, void crystal, phoenix
-- tear, frostgem) via raws.register_inorganics, with reactions to make rough and cut gems. The
-- gem materials have NO ENVIRONMENT_SPEC, so they never appear in worldgen - forge-only exclusives.
-- Gem token set derived from vanilla (ruby/emerald).
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFG_.
-- Reuses the base RGEMS (rough) and CGEMS (cut) submenus. Requires the base mod.

do_once.cf_gems = function()
	-- 1) gem materials
	local inorg = {}
	local function gem(id, sing, plural, colorword, disp3, value, density)
		inorg[#inorg+1] = "[INORGANIC:" .. id .. "]"
		add_generated_info(inorg)
		inorg[#inorg+1] = "[USE_MATERIAL_TEMPLATE:STONE_TEMPLATE]"
		inorg[#inorg+1] = "[TILE:15][IS_GEM:" .. sing .. ":" .. plural .. ":OVERWRITE_SOLID][DISPLAY_COLOR:" .. disp3 .. "][MATERIAL_VALUE:" .. value .. "]"
		inorg[#inorg+1] = "[SOLID_DENSITY:" .. density .. "]"
		inorg[#inorg+1] = "[STATE_COLOR:ALL_SOLID:" .. colorword .. "]"
	end
	-- { id, singular, plural, state_color, display_color, value, density }
	local GEMS = {
		{ "CFG_STARSTONE",   "starstone",    "starstones",    "AZURE",   "1:7:1", 120, 2700 },
		{ "CFG_SOULGEM",     "soulgem",      "soulgems",      "VIOLET",  "5:0:1", 150, 3000 },
		{ "CFG_DRAGONEYE",   "dragon-eye",   "dragon-eyes",   "SCARLET", "4:0:1", 200, 3600 },
		{ "CFG_VOIDCRYSTAL", "void crystal", "void crystals", "BLACK",   "0:0:1", 180, 3200 },
		{ "CFG_PHOENIXTEAR", "phoenix tear", "phoenix tears", "GOLD",    "6:0:1", 200, 2900 },
		{ "CFG_FROSTGEM",    "frostgem",     "frostgems",     "AZURE",   "3:7:1", 100, 2800 },
	}
	for _, g in ipairs(GEMS) do gem(g[1], g[2], g[3], g[4], g[5], g[6], g[7]) end
	raws.register_inorganics(inorg)

	-- 2) reactions: rough + cut, in the base RGEMS / CGEMS submenus
	local out = {}
	local function reaction(id, name, item, qty, mat, cat)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:" .. qty .. ":" .. item .. ":NONE:INORGANIC:" .. mat .. "]"
		out[#out+1] = "[SKILL:CUTGEM]"
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
	end
	for _, g in ipairs(GEMS) do
		local id, plural = g[1], g[3]
		local word = id:gsub("^CFG_", "")
		reaction("CFG_ROUGH_" .. word .. "_10",  "make 10 "  .. plural,       "ROUGH",    10,  id, "RGEMS")
		reaction("CFG_ROUGH_" .. word .. "_100", "make 100 " .. plural,       "ROUGH",    100, id, "RGEMS")
		reaction("CFG_CUT_"   .. word .. "_10",  "make 10 cut "  .. plural,   "SMALLGEM", 10,  id, "CGEMS")
		reaction("CFG_CUT_"   .. word .. "_100", "make 100 cut " .. plural,   "SMALLGEM", 100, id, "CGEMS")
	end
	raws.register_reactions(out)
end
