# FroschRoguelike 🐸

A frog-themed bullet hell dungeon crawler roguelite built in Godot 4, currently in active development as a Maturaarbeit project.

## What is this?

You play as a frog navigating a level filled with enemies that hunt you down. The design philosophy is fast, precise movement and an efficiency-focused gameplay loop.

Currently the project contains a working test level (`testlevel.tscn`) with a playable frog character, spawning enemies, and death effects.

## How to run the project

There is no `.exe` yet — the game is not finished.

To run it yourself you need [Godot Engine 4.x](https://godotengine.org/). Clone the repository, open Godot, click **Import**, and select the `project.godot` file. Then hit the play button.

```
git clone https://github.com/n2ize/FroschRoguelike.git
```

## Code overview

| File | What it does |
|---|---|
| `frog_1.gd` | Player character — WASD movement, sinusoidal breathing animation, rotation wobble |
| `enemie_1.gd` | Enemy AI — follows the player, separates from other enemies to avoid stacking, spawns death effect on contact |
| `gpu_particles_deathparticles.tscn` | Death burst effect — red-to-white particle explosion that plays when an enemy dies |
| `testlevel.tscn` | The current test scene with a timer-based enemy spawner |

Shaders are in the `Shader/` folder and assets in `Assets/`.

## Status

Work in progress. Core systems implemented: player movement, enemy AI, enemy spawning, and death effects. Rooms, progression, bosses, and the tongue mechanic are still being built out.
