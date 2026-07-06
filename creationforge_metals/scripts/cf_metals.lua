-- cf_metals.lua — Creation Forge add-on: Fantasy Metals.
--
-- Adds custom weapon/armor-grade metals DF vanilla lacks (mithril, orichalcum, dragonsteel,
-- meteoric iron, cold iron) via raws.register_inorganics, plus reactions to smelt bars and forge
-- key gear (short sword, battle axe, breastplate, helm, shield) in each. Material properties are
-- derived from vanilla steel/adamantine; tune to taste.
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFMET_.
-- Bars go in the base METAL_BARS submenu; gear in this pack's own "Mythic gear" submenu.

do_once.cf_metals = function()
	-- shared vanilla-derived strength blocks
	local STEEL_STR = {
		"[IMPACT_YIELD:1505000]", "[IMPACT_FRACTURE:2520000]", "[IMPACT_STRAIN_AT_YIELD:940]",
		"[COMPRESSIVE_YIELD:1505000]", "[COMPRESSIVE_FRACTURE:2520000]", "[COMPRESSIVE_STRAIN_AT_YIELD:940]",
		"[TENSILE_YIELD:430000]", "[TENSILE_FRACTURE:720000]", "[TENSILE_STRAIN_AT_YIELD:225]",
		"[TORSION_YIELD:430000]", "[TORSION_FRACTURE:720000]", "[TORSION_STRAIN_AT_YIELD:556]",
		"[SHEAR_YIELD:430000]", "[SHEAR_FRACTURE:720000]", "[SHEAR_STRAIN_AT_YIELD:556]",
		"[BENDING_YIELD:430000]", "[BENDING_FRACTURE:720000]", "[BENDING_STRAIN_AT_YIELD:215]",
	}
	local ADAM_STR = {}
	for _, k in ipairs({ "IMPACT", "COMPRESSIVE", "TENSILE", "TORSION", "SHEAR", "BENDING" }) do
		ADAM_STR[#ADAM_STR+1] = "[" .. k .. "_YIELD:5000000]"
		ADAM_STR[#ADAM_STR+1] = "[" .. k .. "_FRACTURE:5000000]"
		ADAM_STR[#ADAM_STR+1] = "[" .. k .. "_STRAIN_AT_YIELD:0]"
	end

	-- 1) metal definitions
	local inorg = {}
	-- m = { id, name, disp_color("f:b:br"), state_color, value, density, edge, melt, boil, strblock }
	local function metal(m)
		local id, name = m[1], m[2]
		inorg[#inorg+1] = "[INORGANIC:" .. id .. "]"
		add_generated_info(inorg)
		inorg[#inorg+1] = "[USE_MATERIAL_TEMPLATE:METAL_TEMPLATE]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:ALL_SOLID:" .. name .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:LIQUID:molten " .. name .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:GAS:boiling " .. name .. "]"
		inorg[#inorg+1] = "[DISPLAY_COLOR:" .. m[3] .. "]"
		inorg[#inorg+1] = "[BUILD_COLOR:" .. m[3] .. "]"
		inorg[#inorg+1] = "[STATE_COLOR:ALL_SOLID:" .. m[4] .. "]"
		inorg[#inorg+1] = "[MATERIAL_VALUE:" .. m[5] .. "]"
		inorg[#inorg+1] = "[SPEC_HEAT:500]"
		inorg[#inorg+1] = "[MELTING_POINT:" .. m[8] .. "]"
		inorg[#inorg+1] = "[BOILING_POINT:" .. m[9] .. "]"
		inorg[#inorg+1] = "[ITEMS_WEAPON][ITEMS_WEAPON_RANGED][ITEMS_AMMO][ITEMS_DIGGER][ITEMS_ARMOR][ITEMS_ANVIL]"
		inorg[#inorg+1] = "[ITEMS_HARD][ITEMS_METAL][ITEMS_BARRED][ITEMS_SCALED]"
		inorg[#inorg+1] = "[SOLID_DENSITY:" .. m[6] .. "]"
		inorg[#inorg+1] = "[LIQUID_DENSITY:" .. math.floor(m[6] * 0.9) .. "]"
		inorg[#inorg+1] = "[MOLAR_MASS:55845]"
		for _, l in ipairs(m[10]) do inorg[#inorg+1] = l end
		inorg[#inorg+1] = "[MAX_EDGE:" .. m[7] .. "]"
	end
	metal({ "CFMET_MITHRIL",      "mithril",       "7:0:1", "WHITE", 200, 1500, 100000, 12800, 15000, ADAM_STR })
	metal({ "CFMET_ORICHALCUM",   "orichalcum",    "6:0:1", "GOLD",  180, 8000, 11000,  12900, 15200, STEEL_STR })
	metal({ "CFMET_DRAGONSTEEL",  "dragonsteel",   "4:0:1", "RED",   150, 7000, 13000,  18000, 22000, STEEL_STR })
	metal({ "CFMET_METEORIC_IRON","meteoric iron", "0:0:1", "GRAY",  60,  7900, 11000,  12800, 15000, STEEL_STR })
	metal({ "CFMET_COLD_IRON",    "cold iron",     "7:0:0", "GRAY",  50,  7850, 10000,  12700, 14900, STEEL_STR })
	raws.register_inorganics(inorg)

	-- 2) reactions
	local out = {}
	local declared = {}
	local function reaction(id, name, skill, product, cat, catname)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:" .. product .. "]"
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
		if catname and not declared[cat] then declared[cat] = true; out[#out+1] = "[CATEGORY_NAME:" .. catname .. "]" end
	end

	-- { id_suffix, display }
	local METALS = {
		{ "MITHRIL", "mithril" }, { "ORICHALCUM", "orichalcum" }, { "DRAGONSTEEL", "dragonsteel" },
		{ "METEORIC_IRON", "meteoric iron" }, { "COLD_IRON", "cold iron" },
	}
	-- bars -> base METAL_BARS submenu
	for _, m in ipairs(METALS) do
		local mat = "CFMET_" .. m[1]
		reaction("CFMET_BAR_" .. m[1],        "make a bar of " .. m[2],   "SMELT", "100:1:BAR:NONE:INORGANIC:" .. mat,  "METAL_BARS")
		reaction("CFMET_BAR_" .. m[1] .. "_10", "make 10 bars of " .. m[2], "SMELT", "100:10:BAR:NONE:INORGANIC:" .. mat, "METAL_BARS")
	end
	-- gear (vanilla item subtypes in fantasy metals) -> own "Mythic gear" submenu
	-- { forge_skill, product_prefix, id_word, name_word }
	local GEAR = {
		{ "FORGE_WEAPON", "WEAPON:ITEM_WEAPON_SWORD_SHORT", "SWORD",       "short sword" },
		{ "FORGE_WEAPON", "WEAPON:ITEM_WEAPON_AXE_BATTLE",  "AXE",         "battle axe" },
		{ "FORGE_ARMOR",  "ARMOR:ITEM_ARMOR_BREASTPLATE",   "BREASTPLATE", "breastplate" },
		{ "FORGE_ARMOR",  "HELM:ITEM_HELM_HELM",            "HELM",        "helm" },
		{ "FORGE_ARMOR",  "SHIELD:ITEM_SHIELD_SHIELD",      "SHIELD",      "shield" },
	}
	for _, m in ipairs(METALS) do
		local mat = "CFMET_" .. m[1]
		for _, g in ipairs(GEAR) do
			reaction("CFMET_" .. g[3] .. "_" .. m[1], "make a " .. m[2] .. " " .. g[4], g[1],
				"100:1:" .. g[2] .. ":INORGANIC:" .. mat, "CFMET_GEAR", "Mythic gear")
		end
	end
	raws.register_reactions(out)
end
