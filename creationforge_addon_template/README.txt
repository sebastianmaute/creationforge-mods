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

Load order & worldgen
----------------------
Enable base + add-on(s) at world generation, base first (REQUIRES_ID_BEFORE_ME enforces it).
Cannot be added to an existing world.

Worked example: see the creationforge_sandbox pack (grand vault + great cistern).

Public domain.
