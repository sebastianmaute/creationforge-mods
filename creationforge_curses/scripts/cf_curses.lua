-- cf_curses.lua — Creation Forge add-on: Curses & Poisons.
--
-- Adds craftable poisons via custom syndrome-bearing materials. Honest note on delivery: vanilla
-- fortress mode has NO way to coat weapons or apply passive curses, so poisons here deliver two
-- ways that DO work:
--   * poison brews (SYN_INGESTED) - a booze; whoever DRINKS it suffers (assassinate a noble, or
--     poison the whole fort - dwarves drink booze at will, so use with care);
--   * contact venom (SYN_CONTACT) - a powder contaminant; a creature that touches it is afflicted.
-- CE effect syntax derived from vanilla venoms (bark scorpion, etc.).
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFX_,
-- own "Poisons" submenu. Requires the base mod.

do_once.cf_curses = function()
	-- 1) poison materials
	local inorg = {}
	local function drink_poison(id, name, syn)
		inorg[#inorg+1] = "[INORGANIC:" .. id .. "]"
		add_generated_info(inorg)
		inorg[#inorg+1] = "[USE_MATERIAL_TEMPLATE:PLANT_ALCOHOL_TEMPLATE]"
		inorg[#inorg+1] = "[PREFIX:NONE]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:ALL_SOLID:frozen " .. name .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:LIQUID:" .. name .. "]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:GAS:boiling " .. name .. "]"
		for _, l in ipairs(syn) do inorg[#inorg+1] = l end
	end
	local function powder_poison(id, name, syn)
		inorg[#inorg+1] = "[INORGANIC:" .. id .. "]"
		add_generated_info(inorg)
		inorg[#inorg+1] = "[USE_MATERIAL_TEMPLATE:STONE_TEMPLATE]"
		inorg[#inorg+1] = "[STATE_NAME_ADJ:ALL_SOLID:" .. name .. "]"
		inorg[#inorg+1] = "[DISPLAY_COLOR:2:0:1]"
		for _, l in ipairs(syn) do inorg[#inorg+1] = l end
	end

	drink_poison("CFX_MAT_ROTGUT", "rotgut", {
		"[SYNDROME]", "[SYN_NAME:rotgut sickness]", "[SYN_INGESTED]",
		"[CE_NAUSEA:SEV:75:PROB:100:RESISTABLE:SIZE_DILUTES:START:5:PEAK:100:END:2400]",
		"[CE_FEVER:SEV:50:PROB:100:RESISTABLE:SIZE_DILUTES:START:5:PEAK:100:END:2400]",
	})
	drink_poison("CFX_MAT_SLEEPING", "sleeping draught", {
		"[SYNDROME]", "[SYN_NAME:deep sleep]", "[SYN_INGESTED]",
		"[CE_DROWSINESS:SEV:100:PROB:100:RESISTABLE:START:5:PEAK:50:END:1000]",
		"[CE_UNCONSCIOUSNESS:SEV:75:PROB:100:RESISTABLE:SIZE_DILUTES:START:20:PEAK:200:END:1200]",
	})
	drink_poison("CFX_MAT_PARALYSIS", "draught of paralysis", {
		"[SYNDROME]", "[SYN_NAME:paralysis]", "[SYN_INGESTED]",
		"[CE_PARALYSIS:SEV:100:PROB:100:RESISTABLE:SIZE_DILUTES:START:5:PEAK:50:END:600]",
	})
	powder_poison("CFX_MAT_CONTACTVENOM", "contact venom", {
		"[SYNDROME]", "[SYN_NAME:contact venom]", "[SYN_CONTACT]",
		"[CE_PAIN:SEV:75:PROB:100:RESISTABLE:SIZE_DILUTES:START:0:PEAK:20:END:2400]",
		"[CE_SWELLING:SEV:50:PROB:100:RESISTABLE:SIZE_DILUTES:LOCALIZED:VASCULAR_ONLY:START:25:PEAK:100:END:1200]",
		"[CE_BLISTERS:SEV:50:PROB:100:LOCALIZED:VASCULAR_ONLY:RESISTABLE:START:50:PEAK:200:END:1500]",
	})
	raws.register_inorganics(inorg)

	-- 2) reactions
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
		out[#out+1] = "[CATEGORY:CFX_POISONS]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Poisons]" end
	end
	local BARREL = "A:1:BARREL:NONE:NONE:NONE][EMPTY][PRESERVE_REAGENT][DOES_NOT_DETERMINE_PRODUCT_AMOUNT"
	local BAG    = "A:1:BAG:NONE:NONE:NONE][EMPTY][PRESERVE_REAGENT][DOES_NOT_DETERMINE_PRODUCT_AMOUNT"
	reaction("CFX_BREW_ROTGUT",       "brew a barrel of rotgut",               "BREWING",   "100:25:DRINK:NONE:INORGANIC:CFX_MAT_ROTGUT",       BARREL)
	reaction("CFX_BREW_SLEEPING",     "brew a barrel of sleeping draught",     "BREWING",   "100:25:DRINK:NONE:INORGANIC:CFX_MAT_SLEEPING",     BARREL)
	reaction("CFX_BREW_PARALYSIS",    "brew a barrel of draught of paralysis", "BREWING",   "100:25:DRINK:NONE:INORGANIC:CFX_MAT_PARALYSIS",    BARREL)
	reaction("CFX_MAKE_CONTACTVENOM", "make a bag of contact venom",           "HERBALISM", "100:5:POWDER_MISC:NONE:INORGANIC:CFX_MAT_CONTACTVENOM", BAG)
	raws.register_reactions(out)
end
