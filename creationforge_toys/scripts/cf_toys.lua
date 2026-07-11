-- cf_toys.lua — Creation Forge add-on: Toys & Trinkets.
--
-- Custom ITEM_TOY objects DF vanilla lacks (vanilla has only puzzlebox, boat, hammer, axe,
-- mini-forge). Toys are decorative/child-happiness items; the raw is just NAME + HARD_MAT (any hard
-- material: wood, metal, stone, bone, shell, glass — not cloth/leather).
--
-- Add-on pattern: binds base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFY_,
-- declares its own "Toys" submenu. Requires the base mod.

do_once.cf_toys = function()
	-- Item subtypes are defined statically in objects/item_creationforge_toys.txt
	-- (required so DF's graphics loader can bind sprites). The TOYS table below drives reactions:
	-- { id, article, singular, plural, id_word }
	local TOYS = {
		{ "CFY_TOY_SPINNINGTOP",  "a ", "spinning top", "spinning tops", "SPINNINGTOP" },
		{ "CFY_TOY_KALEIDOSCOPE", "a ", "kaleidoscope", "kaleidoscopes", "KALEIDOSCOPE" },
		{ "CFY_TOY_DOLL",         "a ", "doll",         "dolls",         "DOLL" },
		{ "CFY_TOY_ROCKINGHORSE", "a ", "rocking horse","rocking horses","ROCKINGHORSE" },
		{ "CFY_TOY_MARBLES",      "",   "marbles",      "marbles",       "MARBLES" },
		{ "CFY_TOY_YOYO",         "a ", "yo-yo",        "yo-yos",        "YOYO" },
		{ "CFY_TOY_TOYSOLDIER",   "a ", "toy soldier",  "toy soldiers",  "TOYSOLDIER" },
		{ "CFY_TOY_TOYSWORD",     "a ", "toy sword",    "toy swords",    "TOYSWORD" },
	}

	-- 2) reactions in this pack's own submenu
	local out = {}
	local declared = false
	local function reaction(id, name, skill, item, qty, matsuffix)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:" .. qty .. ":TOY:" .. item .. ":" .. matsuffix .. "]"
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:CFY_TOYS]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Toys]" end
	end
	-- { id_suffix, display, skill, product_material_suffix }
	local MATS = {
		{ "FEATHERWOOD", "feather wood", "WOODCRAFT",  "PLANT_MAT:FEATHER:WOOD" },
		{ "COPPER",      "copper",       "METALCRAFT", "INORGANIC:COPPER" },
		{ "SILVER",      "silver",       "METALCRAFT", "INORGANIC:SILVER" },
	}
	for _, t in ipairs(TOYS) do
		local id, art, sg, pl, word = t[1], t[2], t[3], t[4], t[5]
		for _, m in ipairs(MATS) do
			reaction("CFY_" .. word .. "_" .. m[1],          "make " .. art .. m[2] .. " " .. sg, m[3], id, 1,  m[4])
			reaction("CFY_" .. word .. "_" .. m[1] .. "_10", "make 10 " .. m[2] .. " " .. pl,     m[3], id, 10, m[4])
		end
	end
	raws.register_reactions(out)
end
