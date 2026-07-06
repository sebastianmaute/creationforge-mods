-- cf_potions.lua — Creation Forge add-on: Potions & Elixirs.
--
-- EXPERIMENTAL. Exercises the material + syndrome Lua-gen path. Each potion is a custom INORGANIC
-- material built on PLANT_ALCOHOL_TEMPLATE (so it is a drinkable booze) that carries a [SYNDROME]
-- with [SYN_INGESTED] and timed CE_* effects. A dwarf who drinks it gets buffed for a while.
--
-- UNVERIFIED IN-GAME (test before trusting):
--   * whether DF accepts a DRINK item made from an INORGANIC material;
--   * whether dwarves auto-drink it (they treat booze as generic drink, so the whole fort may
--     end up buffed at random — that's the intended chaotic-cheat flavor).
-- Syndrome/CE syntax is derived from vanilla (interaction_vampire, plant_standard gnomeblight).
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFP_,
-- own "Potions" submenu. Requires the base mod.

do_once.cf_potions = function()
	-- 1) potion materials (custom inorganic alcohols with an ingested syndrome)
	local inorg = {}
	local function potionmat(id, liquidname, syn)
		inorg[#inorg+1] = "[INORGANIC:" .. id .. "]"
		add_generated_info(inorg)
		inorg[#inorg+1] = "[USE_MATERIAL_TEMPLATE:PLANT_ALCOHOL_TEMPLATE]"
		inorg[#inorg+1] = "[PREFIX:NONE]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:ALL_SOLID:frozen " .. liquidname .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:LIQUID:" .. liquidname .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:GAS:boiling " .. liquidname .. "]"
		for _, l in ipairs(syn) do inorg[#inorg+1] = l end
	end
	-- effect timing (ticks): onset 20, peak 100, end ~12000 (about half a season)
	potionmat("CFP_MAT_MIGHT", "potion of might", {
		"[SYNDROME]", "[SYN_NAME:might of the mountain]", "[SYN_INGESTED]",
		"[CE_PHYS_ATT_CHANGE:STRENGTH:200:0:TOUGHNESS:175:0:AGILITY:150:0:START:20:PEAK:100:END:12000]",
	})
	potionmat("CFP_MAT_STONESKIN", "draught of stoneskin", {
		"[SYNDROME]", "[SYN_NAME:stoneskin]", "[SYN_INGESTED]",
		-- take half force from all materials (damage reduction); vanilla vampire uses this CE
		"[CE_MATERIAL_FORCE_MULTIPLIER:MAT_MULT:NONE:NONE:1:2:START:20:END:12000]",
	})
	potionmat("CFP_MAT_VIGOR", "elixir of vigor", {
		"[SYNDROME]", "[SYN_NAME:vigor]", "[SYN_INGESTED]",
		"[CE_ADD_TAG:NOEXERT:NOPAIN:NONAUSEA:NOFEAR:NOSTUN:START:20:END:12000]",
	})
	potionmat("CFP_MAT_GENIUS", "elixir of genius", {
		"[SYNDROME]", "[SYN_NAME:genius]", "[SYN_INGESTED]",
		"[CE_MENT_ATT_CHANGE:ANALYTICAL_ABILITY:150:0:FOCUS:150:0:CREATIVITY:150:0:START:20:PEAK:100:END:12000]",
	})
	raws.register_inorganics(inorg)

	-- 2) reactions: brew a barrel of each potion at the Creation Forge
	local out = {}
	local declared = false
	local function reaction(id, name, mat)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[REAGENT:A:1:BARREL:NONE:NONE:NONE][EMPTY][PRESERVE_REAGENT][DOES_NOT_DETERMINE_PRODUCT_AMOUNT]"
		out[#out+1] = "[PRODUCT:100:25:DRINK:NONE:INORGANIC:" .. mat .. "][PRODUCT_TO_CONTAINER:A]"
		out[#out+1] = "[SKILL:BREWING]"
		out[#out+1] = "[CATEGORY:CFP_POTIONS]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Potions]" end
	end
	reaction("CFP_BREW_MIGHT",     "brew a barrel of potion of might",      "CFP_MAT_MIGHT")
	reaction("CFP_BREW_STONESKIN", "brew a barrel of draught of stoneskin", "CFP_MAT_STONESKIN")
	reaction("CFP_BREW_VIGOR",     "brew a barrel of elixir of vigor",      "CFP_MAT_VIGOR")
	reaction("CFP_BREW_GENIUS",    "brew a barrel of elixir of genius",     "CFP_MAT_GENIUS")
	raws.register_reactions(out)
end
