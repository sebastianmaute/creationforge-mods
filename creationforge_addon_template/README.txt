Creation Forge add-on TEMPLATE
==============================

A copy-me skeleton for building add-on packs that extend "The Creation Forge" with extra reactions
and custom items, WITHOUT modifying the base mod.

To make a pack
--------------
1. Copy this whole folder to  creationforge_<yourpack>/  (add a preview.png for the Workshop).
2. info.txt: set a unique [ID:creationforge_<yourpack>], NAME, STEAM_TITLE, DESCRIPTION.
   Keep the two REQUIRES_ID lines (they bind to the base + force load order). Do NOT add
   STEAM_FILE_ID by hand — DF writes it on first upload.
3. scripts/init.lua: change require("cf_addon") to your file name.
4. scripts/cf_addon.lua: rename the file + the do_once.cf_addon key; add your items/reactions.

The contract (what the base guarantees)
---------------------------------------
- Workshops:  CREATION_FORGE, TRAINING_FORGE
- Submenus:   TOOLS, WEAPONS, ARMOR, ARMORSETS, FOOD, DRINKS, MISC, METAL_BARS, ... (base CATS)
Reference these by id. Namespace your own ids (CFX_...). Put [FORTRESS_MODE_ENABLED] on every
reaction so no entity permit is needed.

Custom items that need a sprite
-------------------------------
DO NOT define them with Lua raws.register_items. Lua-registered items exist only inside a
generated world, so DF's launch-time graphics loader can't bind a sprite to them (errorlog:
"Unknown ... graphics token"; the item renders blank). Define custom item subtypes as STATIC raws:
- objects/item_<pack>.txt      : first line = filename, then [OBJECT:ITEM], then [ITEM_TOOL:CFX_...] etc.
- graphics/tile_page_<pack>.txt : [TILE_PAGE:ID] + [FILE:images/x.png] + [TILE_DIM:32:32] + [PAGE_DIM_PIXELS:w:h]
- graphics/graphics_<pack>.txt  : one *_GRAPHICS entry per subtype (greyscale PNG so DF tints by material)
Reactions (Lua) still reference the static item ids. Reuse a vanilla item subtype when one exists
(free sprite). See creationforge_military for a full worked example (weapons/armor + tile page).

Load order & worldgen
----------------------
Enable base + add-on(s) at world generation, base first (REQUIRES_ID_BEFORE_ME enforces it).
Cannot be added to an existing world.

Worked example: see the creationforge_sandbox pack (reactions) and creationforge_military (static
items + sprites).

Public domain.
