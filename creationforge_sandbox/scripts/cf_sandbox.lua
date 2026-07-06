-- cf_sandbox.lua — Creation Forge add-on: Sandbox Tools.
--
-- Demonstrates the add-on pattern: a separate mod that plugs new custom items + reactions into the
-- BASE mod's workshop, without touching the base's files.
--
-- CONTRACT it depends on (kept stable by the base mod):
--   * building id  CREATION_FORGE   (the base workshop; base is loaded first via REQUIRES_ID)
--   * category id  TOOLS            (base already declares its name/parent; we only place into it)
-- Everything else is self-contained. Reactions carry [FORTRESS_MODE_ENABLED], so NO entity
-- permit is needed — the base's entity patch already grants [PERMITTED_BUILDING:CREATION_FORGE].
--
-- Ids are namespaced (CFS_ = Creation Forge Sandbox) to avoid clashing with the base or other packs.

do_once.cf_sandbox = function()
	-- 1) Custom item definitions (DF has no oversized storage tool). Registered as item raws.
	local items = {}
	local function itemdef(id, body)
		items[#items+1] = "[ITEM_TOOL:" .. id .. "]"
		add_generated_info(items)
		for _, l in ipairs(body) do items[#items+1] = l end
	end
	itemdef("CFS_TOOL_VAULT", {
		"[NAME:grand vault:grand vaults]", "[VALUE:20]", "[TILE:127]", "[SIZE:600]",
		"[TOOL_USE:FOOD_STORAGE]", "[CONTAINER_CAPACITY:1000000]", "[HARD_MAT]",
	})
	itemdef("CFS_TOOL_CISTERN", {
		"[NAME:great cistern:great cisterns]", "[VALUE:20]", "[TILE:9]", "[SIZE:600]",
		"[TOOL_USE:LIQUID_CONTAINER]", "[CONTAINER_CAPACITY:1000000]", "[HARD_MAT]",
	})
	raws.register_items(items)

	-- 2) Reactions on the BASE workshop. Tiny self-contained emitter (base's emit{} is not in scope).
	local out = {}
	local function reaction(id, name, skill, item, metal)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"   -- base mod's workshop (contract)
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"          -- usable by any civ, no PERMITTED_REACTION
		out[#out+1] = "[PRODUCT:100:1:TOOL:" .. item .. ":INORGANIC:" .. metal .. "]"
		out[#out+1] = "[SKILL:" .. skill .. "]"
		out[#out+1] = "[CATEGORY:TOOLS]"                 -- base mod's Tools submenu (contract)
	end
	for _, m in ipairs({ { "STEEL", "steel" }, { "ADAMANTINE", "adamantine" } }) do
		reaction("CFS_VAULT_"   .. m[1], "make a " .. m[2] .. " grand vault",   "FORGE_FURNITURE", "CFS_TOOL_VAULT",   m[1])
		reaction("CFS_CISTERN_" .. m[1], "make a " .. m[2] .. " great cistern", "FORGE_FURNITURE", "CFS_TOOL_CISTERN", m[1])
	end
	raws.register_reactions(out)
end
