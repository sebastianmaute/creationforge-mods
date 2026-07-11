-- cf_military.lua — Creation Forge add-on: Weapons & Armor.
--
-- Adds custom WEAPON / ARMOR / HELM / SHIELD subtypes that DF vanilla lacks, craftable at the base
-- Creation Forge in steel & adamantine. Stats are derived from the vanilla item raws (short sword /
-- two-handed sword / battle axe / pike / mace for weapons; breastplate / mail shirt / helm / shield
-- for armor) and are sane approximations -- tune in-game to taste.
--
-- Add-on pattern: binds to base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced
-- CFM_. Declares its own two submenus (Exotic weapons / Exotic armor). Requires the base mod.

do_once.cf_military = function()
	-- Item subtypes are defined statically in objects/item_creationforge_military.txt
	-- (required so DF's graphics loader can bind sprites). Reactions that produce them:

	-- 2) reactions on the base workshop, in this pack's own submenus
	local out = {}
	local declared = {}
	local function reaction(id, name, forge, ptype, item, qty, matsuffix, cat, catname)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:" .. qty .. ":" .. ptype .. ":" .. item .. ":" .. matsuffix .. "]"
		out[#out+1] = "[SKILL:" .. forge .. "]"
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
		if not declared[cat] then declared[cat] = true; out[#out+1] = "[CATEGORY_NAME:" .. catname .. "]" end
	end

	-- { id, ptype, forge, word, article, singular, plural }
	local WEAPONS = {
		{ "CFM_WEAPON_LONGSWORD",  "WEAPON", "FORGE_WEAPON", "LONGSWORD",  "a ", "longsword",  "longswords" },
		{ "CFM_WEAPON_GREATSWORD", "WEAPON", "FORGE_WEAPON", "GREATSWORD", "a ", "greatsword", "greatswords" },
		{ "CFM_WEAPON_KATANA",     "WEAPON", "FORGE_WEAPON", "KATANA",     "a ", "katana",     "katanas" },
		{ "CFM_WEAPON_RAPIER",     "WEAPON", "FORGE_WEAPON", "RAPIER",     "a ", "rapier",     "rapiers" },
		{ "CFM_WEAPON_HALBERD",    "WEAPON", "FORGE_WEAPON", "HALBERD",    "a ", "halberd",    "halberds" },
		{ "CFM_WEAPON_GLAIVE",     "WEAPON", "FORGE_WEAPON", "GLAIVE",     "a ", "glaive",     "glaives" },
		{ "CFM_WEAPON_WARSCYTHE",  "WEAPON", "FORGE_WEAPON", "WARSCYTHE",  "a ", "war scythe", "war scythes" },
		{ "CFM_WEAPON_FLAIL",      "WEAPON", "FORGE_WEAPON", "FLAIL",      "a ", "flail",      "flails" },
	}
	local ARMOR = {
		{ "CFM_ARMOR_FULLPLATE",   "ARMOR",  "FORGE_ARMOR", "FULLPLATE",   "a set of ", "full plate armor", "full plate armors" },
		{ "CFM_ARMOR_BRIGANDINE",  "ARMOR",  "FORGE_ARMOR", "BRIGANDINE",  "a ",        "brigandine",        "brigandines" },
		{ "CFM_ARMOR_SALLET",      "HELM",   "FORGE_ARMOR", "SALLET",      "a ",        "sallet",            "sallets" },
		{ "CFM_ARMOR_GREATHELM",   "HELM",   "FORGE_ARMOR", "GREATHELM",   "a ",        "great helm",        "great helms" },
		{ "CFM_ARMOR_TOWERSHIELD", "SHIELD", "FORGE_ARMOR", "TOWERSHIELD", "a ",        "tower shield",      "tower shields" },
	}
	local METALS = { { "STEEL", "steel" }, { "ADAMANTINE", "adamantine" } }
	local function build(set, cat, catname)
		for _, it in ipairs(set) do
			local id, ptype, forge, word, art, sg, pl = it[1], it[2], it[3], it[4], it[5], it[6], it[7]
			for _, m in ipairs(METALS) do
				reaction("CFM_" .. word .. "_" .. m[1],        "make " .. art .. m[2] .. " " .. sg, forge, ptype, id, 1,  "INORGANIC:" .. m[1], cat, catname)
				reaction("CFM_" .. word .. "_" .. m[1] .. "_10", "make 10 " .. m[2] .. " " .. pl,    forge, ptype, id, 10, "INORGANIC:" .. m[1], cat, catname)
			end
		end
	end
	build(WEAPONS, "CFM_WEAPONS", "Exotic weapons")
	build(ARMOR,   "CFM_ARMOR",   "Exotic armor")
	-- gambeson is soft/leather padded armor -> made in leather, not metal
	reaction("CFM_GAMBESON_LEATHER",    "make a leather gambeson",   "FORGE_ARMOR", "ARMOR", "CFM_ARMOR_GAMBESON", 1,  "CREATURE_MAT:COW:LEATHER", "CFM_ARMOR", "Exotic armor")
	reaction("CFM_GAMBESON_LEATHER_10", "make 10 leather gambesons", "FORGE_ARMOR", "ARMOR", "CFM_ARMOR_GAMBESON", 10, "CREATURE_MAT:COW:LEATHER", "CFM_ARMOR", "Exotic armor")
	raws.register_reactions(out)
end
