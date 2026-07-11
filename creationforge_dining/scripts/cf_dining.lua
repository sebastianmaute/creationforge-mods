-- cf_dining.lua — Creation Forge add-on: Dining Set.
--
-- Custom tableware ITEM_TOOLs (DF vanilla has no dining items beyond the mug):
--   cutlery  = cosmetic craft objects (no TOOL_USE) — decorative / masterwork value / trade
--   serving  = functional containers (teapot/ewer = liquid, tureen = food+liquid, platter = food)
--
-- Demonstrates the OTHER add-on path: this pack declares its OWN new submenu (CFD_DINING) instead
-- of reusing a base category (the sandbox pack reused TOOLS). Still binds to the base workshop.
-- Contract used: building id CREATION_FORGE. Ids namespaced CFD_. Base loaded first via REQUIRES_ID.

do_once.cf_dining = function()
	-- Item subtypes are defined statically in objects/item_creationforge_dining.txt
	-- (required so DF's graphics loader can bind sprites). Reactions that produce them:

	-- 2) Reactions in the add-on's OWN submenu (declared on first use).
	local out = {}
	local declared = false
	local function reaction(id, name, skill, item, qty, matsuffix)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:" .. qty .. ":TOOL:" .. item .. ":" .. matsuffix .. "]"
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:CFD_DINING]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Dining]" end
	end

	-- { item_id, id_word, article, singular, plural }
	local CUTLERY = {
		{ "CFD_TOOL_FORK",       "FORK",       "a ", "fork",        "forks" },
		{ "CFD_TOOL_SPOON",      "SPOON",      "a ", "spoon",       "spoons" },
		{ "CFD_TOOL_KNIFE",      "KNIFE",      "a ", "table knife", "table knives" },
		{ "CFD_TOOL_CHOPSTICKS", "CHOPSTICKS", "",   "chopsticks",  "chopsticks" },
		{ "CFD_TOOL_LADLE",      "LADLE",      "a ", "ladle",       "ladles" },
	}
	local SERVING = {
		{ "CFD_TOOL_TEAPOT",  "TEAPOT",  "a ", "teapot",  "teapots" },
		{ "CFD_TOOL_TUREEN",  "TUREEN",  "a ", "tureen",  "tureens" },
		{ "CFD_TOOL_PLATTER", "PLATTER", "a ", "platter", "platters" },
		{ "CFD_TOOL_EWER",    "EWER",    "a ", "ewer",    "ewers" },
	}
	-- { id_suffix, display, skill, product_material_suffix }
	local METALS = {
		{ "COPPER", "copper", "METALCRAFT", "INORGANIC:COPPER" },
		{ "SILVER", "silver", "METALCRAFT", "INORGANIC:SILVER" },
		{ "GOLD",   "gold",   "METALCRAFT", "INORGANIC:GOLD" },
	}
	local FANCY = {
		{ "SILVER",       "silver",        "METALCRAFT", "INORGANIC:SILVER" },
		{ "GOLD",         "gold",          "METALCRAFT", "INORGANIC:GOLD" },
		{ "CRYSTALGLASS", "crystal glass", "GLASSMAKER",  "GLASS_CRYSTAL:NONE" },
	}
	local function build(set, mats)
		for _, it in ipairs(set) do
			local iid, word, art, sg, pl = it[1], it[2], it[3], it[4], it[5]
			for _, m in ipairs(mats) do
				local suf, disp, skill, mat = m[1], m[2], m[3], m[4]
				reaction("CFD_" .. word .. "_" .. suf,          "make " .. art .. disp .. " " .. sg, skill, iid, 1,  mat)
				reaction("CFD_" .. word .. "_" .. suf .. "_10", "make 10 " .. disp .. " " .. pl,     skill, iid, 10, mat)
			end
		end
	end
	build(CUTLERY, METALS)   -- cutlery in copper/silver/gold
	build(SERVING, FANCY)    -- serving in silver/gold/crystal glass
	raws.register_reactions(out)
end
