-- init.lua — The Creation Forge: mod entry point for DF Lua raw generation.
-- DF runs this at worldgen (v52+); it require()s each generation script.
-- Buildings/graphics/material patch stay as STATIC raws under objects/ (buildings cannot be
-- Lua-generated). This script generates the REACTIONS that the static files used to hold.
require("creationforge")
