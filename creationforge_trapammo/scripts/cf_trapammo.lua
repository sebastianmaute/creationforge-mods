-- cf_trapammo.lua — Creation Forge add-on: Trap & Ammo.
--
-- Adds custom weapon-trap components and heavier ammo, craftable at the base Creation Forge in
-- steel & adamantine. Trap components work immediately in weapon traps; the ammo uses CLASS BOLT /
-- ARROW so existing crossbows / bows fire it. Stats derived from vanilla (giant axe blade,
-- menacing spike, bolts, arrows).
--
-- Add-on pattern: binds base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFT_,
-- REUSES the base TRAPS and AMMUNITION submenus (no re-declare needed). Requires the base mod.

do_once.cf_trapammo = function()
	-- Item subtypes are defined statically in objects/item_creationforge_trapammo.txt
	-- (required so DF's graphics loader can bind sprites). Reactions that produce them:

	-- 2) reactions on the base workshop, reusing base submenus
	local out = {}
	local function reaction(id, name, ptype, item, qty, metal, cat)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:" .. qty .. ":" .. ptype .. ":" .. item .. ":INORGANIC:" .. metal .. "]"
		out[#out+1] = "[SKILL:FORGE_WEAPON]"
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
	end
	local METALS = { { "STEEL", "steel" }, { "ADAMANTINE", "adamantine" } }

	-- trap components -> base TRAPS submenu, x1 and x10
	local TRAPS = {
		{ "CFT_TRAPCOMP_SCYTHEBLADE",  "SCYTHEBLADE",  "scythe blade",      "scythe blades" },
		{ "CFT_TRAPCOMP_SAWBLADE",     "SAWBLADE",     "whirling sawblade", "whirling sawblades" },
		{ "CFT_TRAPCOMP_SPIKEDFLAIL",  "SPIKEDFLAIL",  "spiked flail head", "spiked flail heads" },
	}
	for _, it in ipairs(TRAPS) do
		for _, m in ipairs(METALS) do
			reaction("CFT_" .. it[2] .. "_" .. m[1],        "make a " .. m[2] .. " " .. it[3], "TRAPCOMP", it[1], 1,  m[1], "TRAPS")
			reaction("CFT_" .. it[2] .. "_" .. m[1] .. "_10", "make 10 " .. m[2] .. " " .. it[4], "TRAPCOMP", it[1], 10, m[1], "TRAPS")
		end
	end
	-- ammo -> base AMMUNITION submenu, stacks of 100
	local AMMO = {
		{ "CFT_AMMO_HEAVYBOLT", "HEAVYBOLT", "heavy bolts" },
		{ "CFT_AMMO_BROADHEAD", "BROADHEAD", "broadhead arrows" },
	}
	for _, it in ipairs(AMMO) do
		for _, m in ipairs(METALS) do
			reaction("CFT_" .. it[2] .. "_" .. m[1], "make 100 " .. m[2] .. " " .. it[3], "AMMO", it[1], 100, m[1], "AMMUNITION")
		end
	end
	raws.register_reactions(out)
end
