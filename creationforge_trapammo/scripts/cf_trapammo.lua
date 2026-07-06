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
	-- 1) custom item definitions
	local items = {}
	local function def(header, body)
		items[#items+1] = header
		add_generated_info(items)
		for _, l in ipairs(body) do items[#items+1] = l end
	end
	-- trap components (ITEM_TRAPCOMP)
	def("[ITEM_TRAPCOMP:CFT_TRAPCOMP_SCYTHEBLADE]", {
		"[NAME:scythe blade:scythe blades]", "[ADJECTIVE:giant]", "[SIZE:1600]", "[HITS:1]",
		"[MATERIAL_SIZE:5]", "[METAL]",
		"[ATTACK:EDGE:120000:10000:slash:slashes:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:4:4]",
	})
	def("[ITEM_TRAPCOMP:CFT_TRAPCOMP_SAWBLADE]", {
		"[NAME:sawblade:sawblades]", "[ADJECTIVE:whirling]", "[SIZE:1200]", "[HITS:10]",
		"[MATERIAL_SIZE:4]", "[METAL]",
		"[ATTACK:EDGE:60000:8000:slash:slashes:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:2:2]",
	})
	def("[ITEM_TRAPCOMP:CFT_TRAPCOMP_SPIKEDFLAIL]", {
		"[NAME:flail head:flail heads]", "[ADJECTIVE:spiked]", "[SIZE:1400]", "[HITS:1]",
		"[MATERIAL_SIZE:5]", "[METAL]",
		"[ATTACK:BLUNT:20:400:bash:bashes:NO_SUB:1500]", "[ATTACK_PREPARE_AND_RECOVER:4:4]",
		"[ATTACK:EDGE:10:5000:stab:stabs:spikes:1000]", "[ATTACK_PREPARE_AND_RECOVER:4:4]",
	})
	-- ammo (ITEM_AMMO) — reuse vanilla launcher classes
	def("[ITEM_AMMO:CFT_AMMO_HEAVYBOLT]", {
		"[NAME:heavy bolt:heavy bolts]", "[CLASS:BOLT]", "[SIZE:250]",
		"[ATTACK:EDGE:10:2000:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	def("[ITEM_AMMO:CFT_AMMO_BROADHEAD]", {
		"[NAME:broadhead arrow:broadhead arrows]", "[CLASS:ARROW]", "[SIZE:200]",
		"[ATTACK:EDGE:30:1500:stab:stabs:NO_SUB:1000]", "[ATTACK_PREPARE_AND_RECOVER:3:3]",
	})
	raws.register_items(items)

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
