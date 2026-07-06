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
	-- 1) custom item definitions. Header written explicitly per item (item class varies:
	--    ITEM_WEAPON / ITEM_ARMOR / ITEM_HELM / ITEM_SHIELD).
	local items = {}
	local function def(header, body)
		items[#items+1] = header
		add_generated_info(items)
		for _, l in ipairs(body) do items[#items+1] = l end
	end

	-- ---- WEAPONS (ITEM_WEAPON) ----
	def("[ITEM_WEAPON:CFM_WEAPON_LONGSWORD]", {
		"[NAME:longsword:longswords]", "[SIZE:500]", "[SKILL:SWORD]", "[TWO_HANDED:45000]",
		"[MINIMUM_SIZE:32500]", "[MATERIAL_SIZE:4]",
		"[ATTACK:EDGE:50000:6000:slash:slashes:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:50:3000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:BLUNT:100:1000:strike:strikes:pommel:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_GREATSWORD]", {
		"[NAME:greatsword:greatswords]", "[SIZE:950]", "[SKILL:SWORD]", "[TWO_HANDED:77500]",
		"[MINIMUM_SIZE:62500]", "[MATERIAL_SIZE:6]",
		"[ATTACK:EDGE:100000:9000:slash:slashes:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:50:4000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:BLUNT:100000:9000:slap:slaps:flat:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_KATANA]", {
		"[NAME:katana:katanas]", "[SIZE:450]", "[SKILL:SWORD]", "[TWO_HANDED:45000]",
		"[MINIMUM_SIZE:32500]", "[MATERIAL_SIZE:4]",
		"[ATTACK:EDGE:60000:6000:slash:slashes:NO_SUB:1300]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:50:3000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_RAPIER]", {
		"[NAME:rapier:rapiers]", "[SIZE:300]", "[SKILL:SWORD]", "[TWO_HANDED:37500]",
		"[MINIMUM_SIZE:30000]", "[MATERIAL_SIZE:3]",
		"[ATTACK:EDGE:20:5000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:20000:3000:slash:slashes:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_HALBERD]", {
		"[NAME:halberd:halberds]", "[SIZE:1000]", "[SKILL:AXE]", "[TWO_HANDED:60000]",
		"[MINIMUM_SIZE:50000]", "[MATERIAL_SIZE:5]",
		"[ATTACK:EDGE:40000:8000:hack:hacks:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:20:8000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:BLUNT:10000:6000:bash:bashes:shaft:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_GLAIVE]", {
		"[NAME:glaive:glaives]", "[SIZE:900]", "[SKILL:SWORD]", "[TWO_HANDED:55000]",
		"[MINIMUM_SIZE:47500]", "[MATERIAL_SIZE:5]",
		"[ATTACK:EDGE:60000:7000:slash:slashes:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:EDGE:20:6000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_WARSCYTHE]", {
		"[NAME:war scythe:war scythes]", "[SIZE:800]", "[SKILL:SWORD]", "[TWO_HANDED:52500]",
		"[MINIMUM_SIZE:45000]", "[MATERIAL_SIZE:4]",
		"[ATTACK:EDGE:70000:6000:slash:slashes:NO_SUB:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
		"[ATTACK:BLUNT:10000:6000:bash:bashes:shaft:1250]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_WEAPON:CFM_WEAPON_FLAIL]", {
		"[NAME:flail:flails]", "[SIZE:800]", "[SKILL:MACE]", "[TWO_HANDED:37500]",
		"[MINIMUM_SIZE:32500]", "[MATERIAL_SIZE:3]",
		"[ATTACK:BLUNT:20:250:bash:bashes:NO_SUB:2000]", "[ATTACK_PREPARE_AND_RECOVER:4:4]",
	})

	-- ---- ARMOR (ITEM_ARMOR / HELM / SHIELD) ----
	def("[ITEM_ARMOR:CFM_ARMOR_FULLPLATE]", {
		"[NAME:full plate armor:full plate armors]", "[ARMORLEVEL:3]", "[UBSTEP:MAX]", "[LBSTEP:2]",
		"[SHAPED]", "[LAYER:ARMOR]", "[COVERAGE:100]", "[LAYER_SIZE:25]", "[LAYER_PERMIT:60]",
		"[MATERIAL_SIZE:12]", "[HARD]", "[METAL]",
	})
	def("[ITEM_ARMOR:CFM_ARMOR_BRIGANDINE]", {
		"[NAME:brigandine:brigandines]", "[ARMORLEVEL:2]", "[UBSTEP:1]", "[LBSTEP:1]",
		"[LAYER:ARMOR]", "[COVERAGE:100]", "[LAYER_SIZE:12]", "[LAYER_PERMIT:40]",
		"[MATERIAL_SIZE:7]", "[HARD]", "[METAL]",
	})
	def("[ITEM_ARMOR:CFM_ARMOR_GAMBESON]", {
		"[NAME:gambeson:gambesons]", "[ARMORLEVEL:1]", "[UBSTEP:1]", "[LBSTEP:1]",
		"[LAYER:UNDER]", "[COVERAGE:100]", "[LAYER_SIZE:8]", "[LAYER_PERMIT:30]",
		"[MATERIAL_SIZE:4]", "[SOFT]", "[LEATHER]", "[STRUCTURAL_ELASTICITY_WOVEN_THREAD]",
	})
	def("[ITEM_HELM:CFM_ARMOR_SALLET]", {
		"[NAME:sallet:sallets]", "[ARMORLEVEL:2]", "[SHAPED]", "[LAYER:ARMOR]", "[COVERAGE:100]",
		"[LAYER_SIZE:30]", "[LAYER_PERMIT:20]", "[MATERIAL_SIZE:2]", "[HARD]", "[METAL]",
	})
	def("[ITEM_HELM:CFM_ARMOR_GREATHELM]", {
		"[NAME:great helm:great helms]", "[ARMORLEVEL:2]", "[SHAPED]", "[LAYER:ARMOR]", "[COVERAGE:100]",
		"[LAYER_SIZE:35]", "[LAYER_PERMIT:20]", "[MATERIAL_SIZE:3]", "[HARD]", "[METAL]",
	})
	def("[ITEM_SHIELD:CFM_ARMOR_TOWERSHIELD]", {
		"[NAME:tower shield:tower shields]", "[ARMORLEVEL:2]", "[BLOCKCHANCE:30]", "[UPSTEP:3]",
		"[MATERIAL_SIZE:6]",
	})
	raws.register_items(items)

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
