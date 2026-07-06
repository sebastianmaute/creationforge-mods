# Creation Forge — Dwarf Fortress mods

A cheat/QoL mod family for **Dwarf Fortress** (v52.01+). A base "Creation Forge" workshop mod
plus additive add-on packs, most built with DF's **vanilla Lua raw generation** (not DFHack).

Base + 13 packs are on the Steam Workshop:
[base item `2898393468`](https://steamcommunity.com/sharedfiles/filedetails/?id=2898393468) ·
[collection `3758458696`](https://steamcommunity.com/sharedfiles/filedetails/?id=3758458696).
This repo is the mod **source**.

## Layout

Each folder is a self-contained DF mod (`info.txt` + `scripts/` and/or raw `objects/`).

| Folder | What it adds |
|---|---|
| `creationforge` | Base mod — Creation Forge / Training Forge workshops (static raws + a Lua port). |
| `creationforge_lua` | Standalone Lua-gen base: one script generates 1104 reactions + 2 custom items (`BOWL`/`PLATE`) via `raws.register_*`. Published base (Workshop `2898393468`). |
| `creationforge_sandbox` | Mega-containers (reuses base `TOOLS` submenu). |
| `creationforge_dining` | Cutlery + serving vessels (own `Dining` submenu). |
| `creationforge_military` | Exotic weapons + armor (custom subtypes, vanilla-derived stats). |
| `creationforge_trapammo` | Custom trap components + heavier ammo. |
| `creationforge_toys` | Custom toys (`ITEM_TOY`). |
| `creationforge_potions` | Drinkable buff potions via inorganic alcohols + ingested syndrome. *Experimental.* |
| `creationforge_metals` | Custom weapon/armor-grade metals (mithril, orichalcum, …) + bar/gear reactions. |
| `creationforge_bulk` | QoL 500-stack reactions of common goods. |
| `creationforge_gems` | Custom gemstones (`[IS_GEM]`, forge-only) + rough/cut reactions. |
| `creationforge_palette` | QoL 100-stack blocks in a 20-color vanilla-stone palette. |
| `creationforge_kits` | One-click multi-product "starter kit" bundles. |
| `creationforge_flora` | Custom subterranean crops (plump-helmet clones). |
| `creationforge_curses` | Craftable poisons — ingested brews + contact-venom powder. *Experimental.* |
| `creationforge_addon_template` | Copy-me skeleton for a new add-on pack. |

## Architecture

- **Base + additive packs.** A pack ships **only** `scripts/` — reactions/items on the base
  building (`[BUILDING:CREATION_FORGE:NONE]`) stamped `[FORTRESS_MODE_ENABLED]`, so no entity
  permit or building/graphics files are needed; the base provides those.
- **Load order.** Each pack's `info.txt` declares `[REQUIRES_ID:creationforge]` +
  `[REQUIRES_ID_BEFORE_ME:creationforge]`, so it loads after the base and reuses its building ids.
- Namespace every pack's ids; reuse a base submenu (`[CATEGORY:TOOLS]`, …) or declare your own.

## Install

Copy the folders you want into DF's `mods/` directory (base first), enable them per-world at
worldgen. Full walkthrough — install paths, load order, enable, verify, troubleshoot — in
[`INSTALL.md`](INSTALL.md).

## Notes

- Built for DF **vanilla** Lua modding (added experimentally v51.06, shipped v52.01) — **not**
  DFHack. Randomness uses DF's RNG (`trandom`/`pick_*`), never `math.random`.
- `STEAM_FILE_ID` values in `info.txt` are public Workshop item ids.
