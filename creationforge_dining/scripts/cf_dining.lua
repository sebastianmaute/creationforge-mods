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
	-- 1) Item definitions
	local items = {}
	local function itemdef(id, body)
		items[#items+1] = "[ITEM_TOOL:" .. id .. "]"
		add_generated_info(items)
		for _, l in ipairs(body) do items[#items+1] = l end
	end
	-- cutlery (cosmetic, no TOOL_USE)
	itemdef("CFD_TOOL_FORK",       { "[NAME:fork:forks]",               "[VALUE:5]", "[TILE:47]",  "[SIZE:50]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_SPOON",      { "[NAME:spoon:spoons]",             "[VALUE:5]", "[TILE:126]", "[SIZE:50]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_KNIFE",      { "[NAME:table knife:table knives]", "[VALUE:5]", "[TILE:45]",  "[SIZE:50]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_CHOPSTICKS", { "[NAME:chopsticks:chopsticks]",    "[VALUE:5]", "[TILE:61]",  "[SIZE:40]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_LADLE",      { "[NAME:ladle:ladles]",             "[VALUE:8]", "[TILE:106]", "[SIZE:80]", "[HARD_MAT]" })
	-- serving vessels (functional containers)
	itemdef("CFD_TOOL_TEAPOT",  { "[NAME:teapot:teapots]",   "[VALUE:15]", "[TILE:243]", "[SIZE:200]", "[TOOL_USE:LIQUID_CONTAINER]", "[CONTAINER_CAPACITY:5000]",  "[HARD_MAT]" })
	itemdef("CFD_TOOL_TUREEN",  { "[NAME:tureen:tureens]",   "[VALUE:15]", "[TILE:247]", "[SIZE:300]", "[TOOL_USE:FOOD_STORAGE]", "[TOOL_USE:LIQUID_CONTAINER]", "[CONTAINER_CAPACITY:10000]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_PLATTER", { "[NAME:platter:platters]", "[VALUE:12]", "[TILE:111]", "[SIZE:150]", "[TOOL_USE:FOOD_STORAGE]", "[CONTAINER_CAPACITY:5000]", "[HARD_MAT]" })
	itemdef("CFD_TOOL_EWER",    { "[NAME:ewer:ewers]",       "[VALUE:12]", "[TILE:244]", "[SIZE:180]", "[TOOL_USE:LIQUID_CONTAINER]", "[CONTAINER_CAPACITY:5000]", "[HARD_MAT]" })
	raws.register_items(items)

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
