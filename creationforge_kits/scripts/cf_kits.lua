-- cf_kits.lua — Creation Forge add-on: Starter Kits.
--
-- One-click bundle reactions: each brews a whole kit of vanilla items in a single job. No custom
-- items - just multi-product reactions. Great for instant embark supply or a fresh fort.
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFK_,
-- own "Starter kits" submenu. Requires the base mod.

do_once.cf_kits = function()
	local out = {}
	local declared = false
	-- prods: list of product entries. Each is either "payload" or { "payload", dim = N }.
	local function kit(id, name, prods)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		for _, p in ipairs(prods) do
			if type(p) == "table" then
				out[#out+1] = "[PRODUCT:" .. p[1] .. "]"
				out[#out+1] = "[PRODUCT_DIMENSION:" .. p.dim .. "]"
			else
				out[#out+1] = "[PRODUCT:" .. p .. "]"
			end
		end
		out[#out+1] = "[SKILL:ORGANIZATION]"
		out[#out+1] = "[CATEGORY:CFK_KITS]"
		if not declared then declared = true; out[#out+1] = "[CATEGORY_NAME:Starter kits]" end
	end

	kit("CFK_BASIC", "conjure a basic starter kit", {
		"100:2:WEAPON:ITEM_WEAPON_PICK:INORGANIC:IRON",
		"100:1:WEAPON:ITEM_WEAPON_AXE_BATTLE:INORGANIC:IRON",
		"100:1:ANVIL:NONE:INORGANIC:IRON",
		"100:50:PLANT:NONE:PLANT_MAT:MUSHROOM_HELMET_PLUMP:STRUCTURAL",
		"100:25:SEEDS:NONE:PLANT_MAT:MUSHROOM_HELMET_PLUMP:SEED",
		"100:20:WOOD:NONE:PLANT_MAT:FEATHER:WOOD",
		"100:20:BAR:NONE:INORGANIC:COPPER",
		"100:10:SKIN_TANNED:NONE:CREATURE_MAT:COW:LEATHER",
		{ "100:10:CLOTH:NONE:CREATURE_MAT:SPIDER_CAVE_GIANT:SILK", dim = 10000 },
	})

	kit("CFK_MILITARY", "conjure a military kit (steel)", {
		"100:5:ARMOR:ITEM_ARMOR_BREASTPLATE:INORGANIC:STEEL",
		"100:5:HELM:ITEM_HELM_HELM:INORGANIC:STEEL",
		"100:5:SHOES:ITEM_SHOES_BOOTS:INORGANIC:STEEL",
		"100:5:PANTS:ITEM_PANTS_LEGGINGS:INORGANIC:STEEL",
		"100:5:SHIELD:ITEM_SHIELD_SHIELD:INORGANIC:STEEL",
		"100:5:WEAPON:ITEM_WEAPON_SWORD_SHORT:INORGANIC:STEEL",
		"100:5:WEAPON:ITEM_WEAPON_AXE_BATTLE:INORGANIC:STEEL",
		"100:5:WEAPON:ITEM_WEAPON_CROSSBOW:INORGANIC:STEEL",
		"100:100:AMMO:ITEM_AMMO_BOLTS:INORGANIC:STEEL",
	})

	kit("CFK_CRAFT", "conjure a craft kit", {
		"100:10:BAR:NONE:INORGANIC:COPPER",
		"100:10:BAR:NONE:INORGANIC:SILVER",
		"100:10:BAR:NONE:INORGANIC:GOLD",
		"100:20:ROUGH:NONE:INORGANIC:CRYSTAL_ROCK",
		"100:10:WOOD:NONE:PLANT_MAT:FEATHER:WOOD",
		"100:20:BLOCKS:NONE:INORGANIC:MICROCLINE",
		{ "100:20:CLOTH:NONE:CREATURE_MAT:SPIDER_CAVE_GIANT:SILK", dim = 10000 },
		{ "100:20:THREAD:NONE:PLANT_MAT:GRASS_TAIL_PIG:THREAD", dim = 15000 },
	})

	raws.register_reactions(out)
end
