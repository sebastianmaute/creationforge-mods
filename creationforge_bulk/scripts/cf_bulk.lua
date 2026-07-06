-- cf_bulk.lua — Creation Forge add-on: Bulk Everything.
--
-- Quality-of-life pack: one-click 500-stacks of the most-wanted logistics goods, for megaprojects
-- and instant supply. Pure reactions, no custom items. Reuses the base mod's existing submenus.
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFB_.
-- Requires the base mod (which provides the workshop + the submenus referenced here).

do_once.cf_bulk = function()
	local out = {}
	local function reaction(id, name, skill, payload, cat, dim)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:" .. payload .. "]"
		if dim then out[#out+1] = "[PRODUCT_DIMENSION:" .. dim .. "]" end
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
	end

	-- metal bars x500 -> base Metals submenu
	local BARS = { "IRON", "STEEL", "COPPER", "BRONZE", "SILVER", "GOLD", "ADAMANTINE" }
	local disp = { IRON = "iron", STEEL = "steel", COPPER = "copper", BRONZE = "bronze",
	               SILVER = "silver", GOLD = "gold", ADAMANTINE = "adamantine" }
	for _, m in ipairs(BARS) do
		reaction("CFB_BAR_" .. m, "make 500 " .. disp[m] .. " bars", "SMELT",
			"100:500:BAR:NONE:INORGANIC:" .. m, "METAL_BARS")
	end

	-- other logistics goods x500, each into its base submenu
	reaction("CFB_BLOCKS",  "make 500 microcline blocks",   "MASONRY",      "100:500:BLOCKS:NONE:INORGANIC:MICROCLINE",            "BLOCKS")
	reaction("CFB_LOGS",    "make 500 feather wood logs",   "WOODCUTTING",  "100:500:WOOD:NONE:PLANT_MAT:FEATHER:WOOD",            "WOOD")
	reaction("CFB_COKE",    "make 500 coke",                "WOOD_BURNING", "100:500:BAR:NONE:COAL:COKE",                          "METAL_BARS")
	reaction("CFB_CLOTH",   "make 500 silk cloth",          "CLOTHESMAKING","100:500:CLOTH:NONE:CREATURE_MAT:SPIDER_CAVE_GIANT:SILK","CLOTH", 10000)
	reaction("CFB_THREAD",  "make 500 plant thread",        "SPINNING",     "100:500:THREAD:NONE:PLANT_MAT:GRASS_TAIL_PIG:THREAD", "CLOTH", 15000)
	reaction("CFB_LEATHER", "make 500 cow leather",         "LEATHERWORK",  "100:500:SKIN_TANNED:NONE:CREATURE_MAT:COW:LEATHER",   "LEATHER")
	reaction("CFB_FOOD",    "make 500 plump helmets",       "PLANT",        "100:500:PLANT:NONE:PLANT_MAT:MUSHROOM_HELMET_PLUMP:STRUCTURAL", "RAW_PLANTS")
	reaction("CFB_BOLTS",   "make 500 iron bolts",          "FORGE_WEAPON", "100:500:AMMO:ITEM_AMMO_BOLTS:INORGANIC:IRON",         "AMMUNITION")
	reaction("CFB_ARROWS",  "make 500 iron arrows",         "FORGE_WEAPON", "100:500:AMMO:ITEM_AMMO_ARROWS:INORGANIC:IRON",        "AMMUNITION")

	raws.register_reactions(out)
end
