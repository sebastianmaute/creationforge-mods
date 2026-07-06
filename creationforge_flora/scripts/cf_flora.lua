-- cf_flora.lua — Creation Forge add-on: Fantasy Flora.
--
-- Adds custom subterranean crops DF vanilla lacks (goldcap, dreamshroom, ember cap) via
-- raws.register_plants. Each is modeled on the vanilla plump helmet: a structural plant that is
-- edible, brews into a themed drink, and has seeds - so it's also plantable in farm plots. Reactions
-- conjure the raw plant and its seeds at the Creation Forge.
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFF_,
-- own "Fantasy flora" submenu. Requires the base mod.

do_once.cf_flora = function()
	-- 1) plant definitions (plump-helmet clones)
	local plants = {}
	local function plant(id, name, plural, adj, prefstr, drink, colorword, disp3, seedname)
		local p = plants
		p[#p+1] = "[PLANT:" .. id .. "]"
		add_generated_info(p)
		p[#p+1] = "[NAME:" .. name .. "][NAME_PLURAL:" .. plural .. "][ADJ:" .. adj .. "]"
		p[#p+1] = "[USE_MATERIAL_TEMPLATE:STRUCTURAL:STRUCTURAL_PLANT_TEMPLATE]"
		p[#p+1] = "[MATERIAL_VALUE:2]"
		p[#p+1] = "[MATERIAL_REACTION_PRODUCT:DRINK_MAT:LOCAL_PLANT_MAT:DRINK]"
		p[#p+1] = "[MATERIAL_REACTION_PRODUCT:SEED_MAT:LOCAL_PLANT_MAT:SEED]"
		p[#p+1] = "[BASIC_MAT:LOCAL_PLANT_MAT:STRUCTURAL]"
		p[#p+1] = "[EDIBLE_VERMIN][EDIBLE_RAW][EDIBLE_COOKED]"
		p[#p+1] = "[PICKED_TILE:6][PICKED_COLOR:" .. disp3 .. "]"
		p[#p+1] = "[GROWDUR:300][VALUE:2]"
		p[#p+1] = "[USE_MATERIAL_TEMPLATE:DRINK:PLANT_ALCOHOL_TEMPLATE]"
		p[#p+1] = "[STATE_NAME_ADJ:ALL_SOLID:frozen " .. drink .. "]"
		p[#p+1] = "[STATE_NAME_ADJ:LIQUID:" .. drink .. "]"
		p[#p+1] = "[STATE_NAME_ADJ:GAS:boiling " .. drink .. "]"
		p[#p+1] = "[STATE_COLOR:ALL:" .. colorword .. "]"
		p[#p+1] = "[MATERIAL_VALUE:2]"
		p[#p+1] = "[DISPLAY_COLOR:" .. disp3 .. "]"
		p[#p+1] = "[EDIBLE_RAW][EDIBLE_COOKED][PREFIX:NONE]"
		p[#p+1] = "[DRINK:LOCAL_PLANT_MAT:DRINK]"
		p[#p+1] = "[USE_MATERIAL_TEMPLATE:SEED:SEED_TEMPLATE]"
		p[#p+1] = "[MATERIAL_VALUE:1][EDIBLE_VERMIN][EDIBLE_COOKED]"
		p[#p+1] = "[SEED:" .. seedname .. ":" .. seedname .. ":4:0:1:LOCAL_PLANT_MAT:SEED]"
		p[#p+1] = "[SPRING][SUMMER][AUTUMN][WINTER][FREQUENCY:100][CLUSTERSIZE:5]"
		p[#p+1] = "[PREFSTRING:" .. prefstr .. "]"
		p[#p+1] = "[WET][DRY][BIOME:SUBTERRANEAN_WATER][UNDERGROUND_DEPTH:1:3]"
		p[#p+1] = "[SHRUB_TILE:58][DEAD_SHRUB_TILE:58][SHRUB_COLOR:" .. disp3 .. "][DEAD_SHRUB_COLOR:0:0:1]"
	end
	-- { id, name, plural, adj, prefstring, drink, state_color, display_color, seed_name }
	local FLORA = {
		{ "CFF_GOLDCAP",     "goldcap",     "goldcaps",     "goldcap",     "golden gills",   "goldmead",   "GOLD",   "6:0:1", "goldcap spawn" },
		{ "CFF_DREAMSHROOM", "dreamshroom", "dreamshrooms", "dreamshroom", "drifting spores","dreamwine",  "VIOLET", "5:0:1", "dreamshroom spawn" },
		{ "CFF_EMBERCAP",    "ember cap",   "ember caps",   "ember cap",   "glowing caps",   "fire brandy","SCARLET","4:0:1", "ember cap spawn" },
	}
	for _, f in ipairs(FLORA) do plant(f[1], f[2], f[3], f[4], f[5], f[6], f[7], f[8], f[9]) end
	raws.register_plants(plants)

	-- 2) reactions: conjure raw plant + seeds
	local out = {}
	local declared = false
	local function reaction(id, name, skill, payload, reagent)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[REAGENT:" .. reagent .. "]"
		out[#out+1] = "[PRODUCT:" .. payload .. "][PRODUCT_TO_CONTAINER:A]"
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:CFF_FLORA]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Fantasy flora]" end
	end
	local BARREL = "A:1:BARREL:NONE:NONE:NONE][EMPTY][PRESERVE_REAGENT][DOES_NOT_DETERMINE_PRODUCT_AMOUNT"
	local BAG    = "A:1:BAG:NONE:NONE:NONE][EMPTY][PRESERVE_REAGENT][DOES_NOT_DETERMINE_PRODUCT_AMOUNT"
	for _, f in ipairs(FLORA) do
		local id, name, plural = f[1], f[2], f[3]
		reaction("CFF_GROW_" .. id, "make 60 " .. plural, "PLANT",
			"100:60:PLANT:NONE:PLANT_MAT:" .. id .. ":STRUCTURAL", BARREL)
		reaction("CFF_SEED_" .. id, "make 25 " .. name .. " seeds", "PROCESSPLANTS",
			"100:25:SEEDS:NONE:PLANT_MAT:" .. id .. ":SEED", BAG)
	end
	raws.register_reactions(out)
end
