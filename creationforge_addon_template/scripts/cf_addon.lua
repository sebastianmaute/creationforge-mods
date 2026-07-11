-- cf_addon.lua — TEMPLATE for a Creation Forge add-on pack.
--
-- Copy this folder, rename it + the [ID] in info.txt + this file (and the require in init.lua),
-- then fill in your reactions below. An add-on needs no building or entity files — the base
-- "The Creation Forge" mod (loaded first via REQUIRES_ID) provides those. Reactions are Lua;
-- custom ITEMS that need a sprite must be STATIC raws + graphics files (see the item note below).
--
-- CONTRACT provided by the base (safe to reference):
--   building ids : CREATION_FORGE, TRAINING_FORGE
--   category ids : TOOLS, WEAPONS, ARMOR, ARMORSETS, FOOD, DRINKS, MISC, ... (see base CATS table)
-- Rules:
--   * Give this do_once a UNIQUE key (do_once.cf_<pack>) and namespace every reaction/item id
--     (e.g. CFX_...) so nothing clashes with the base or sibling packs.
--   * Put [FORTRESS_MODE_ENABLED] on every reaction -> no [PERMITTED_REACTION] needed.
--   * Reference the base workshop with [BUILDING:CREATION_FORGE:NONE].
--   * To place a reaction in a base submenu, emit [CATEGORY:<id>] (do NOT redeclare its name/parent
--     unless it fails to group in-game). To make your own submenu, also emit
--     [CATEGORY_NAME:...] and optionally [CATEGORY_PARENT:...] on its first use.

do_once.cf_addon = function()   -- <-- rename to cf_<pack>
	-- Custom items: DO NOT use raws.register_items if the item needs a sprite. Lua-registered items
	-- exist only inside a generated world, so DF's launch-time graphics loader can't bind a sprite to
	-- them -> "Unknown ... graphics token" in errorlog and a blank tile. Define custom item subtypes as
	-- STATIC raws instead (this is what the shipped packs do, e.g. creationforge_military):
	--   objects/item_<pack>.txt      -- first line = filename, then [OBJECT:ITEM], then [ITEM_TOOL:CFX_...] etc.
	--   graphics/tile_page_<pack>.txt + graphics/graphics_<pack>.txt  -- greyscale tile page + one entry per subtype
	-- Reactions below (Lua) still reference those static item ids. Prefer reusing a vanilla item subtype
	-- when one exists (free sprite + stats). register_items is fine ONLY for items you never need to graphic.

	-- Reactions on the base workshop.
	local out = {}
	local function reaction(id, name, skill, product, cat)
		out[#out+1] = "[REACTION:" .. id .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:" .. name .. "]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:" .. product .. "]"      -- e.g. "100:1:BAR:NONE:INORGANIC:GOLD"
		if skill then out[#out+1] = "[SKILL:" .. skill .. "]" end
		out[#out+1] = "[CATEGORY:" .. cat .. "]"
	end

	-- Example (delete): reaction("CFX_MAKE_GOLD_BAR", "make a gold bar", "SMELT", "100:1:BAR:NONE:INORGANIC:GOLD", "METAL_BARS")

	raws.register_reactions(out)
end
