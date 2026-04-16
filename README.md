# 🎮 Tetris Gamba — FPGA Implementation

> A hardware-implemented Tetris game on the **Basys3 FPGA**, featuring VGA display, OLED score tracking, background music, and a unique block reroll mechanic.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Hardware Components](#hardware-components)
- [How to Play](#how-to-play)
- [Controls](#controls)
- [Output Interfaces](#output-interfaces)
- [System Architecture](#system-architecture)
- [Team & Contributions](#team--contributions)
- [References](#references)

---

## Overview

**Tetris Gamba** is a Tetris-style game implemented entirely in hardware on the **Basys3 FPGA**. The game runs on a 10×20 grid with 5 block types, real-time collision detection, line clearing, and score calculation — all handled in hardware logic. A unique "reroll" mechanic allows players to randomly replace the current block, adding a strategic gambling element to the classic Tetris formula.

---

## Features

- 🧱 **10×20 gameplay grid** with 5 distinct block types
- 🎲 **Reroll mechanic** — replace the current block at the cost of a reroll charge
- ⚡ **Dynamic fall speed** — scales from 1 Hz to 3 Hz based on score
- 🔀 **Pseudo-random block generation** via 4-bit LFSR
- 🖥️ **VGA display** — start menu, gameplay screen, and game-over screen
- 📊 **Real-time score display** on OLED
- 🎵 **Background music** output via speaker and amplifier
- 💡 **LED speed indicators** that blink according to current block fall speed

---

## Hardware Components

| Component | Role |
|---|---|
| Basys3 FPGA | Main processing unit |
| VGA Display | Renders game screens |
| OLED Display | Shows current score |
| 7-Segment Display | Shows remaining rerolls |
| Push Buttons (×5) | Player input |
| Switches (×16) | Reroll count selection + game start |
| Speaker + Amplifier | Background music output |
| LEDs 1–15 | Block fall speed indicator |

---

## How to Play

1. **Start Menu** is displayed on the VGA screen on power-up.
2. Use **switches 1–15** to select the number of rerolls (via priority encoder).
3. Flip **Switch 0** to begin the game.
4. Play Tetris on the 10×20 grid — clear lines to score points!
5. The game ends when a new block spawns out of bounds (**Game Over screen** is displayed).
6. Turn off **Switch 0** to return to the start screen.

---

## Controls

| Button | Action |
|---|---|
| `btnU` (Up) | Rotate active block clockwise |
| `btnL` (Left) | Move block left |
| `btnR` (Right) | Move block right |
| `btnD` (Down) | Increase falling speed (held) |
| `btnC` (Centre) | Initiate a reroll — randomly replaces the current block |

---

## Output Interfaces

| Interface | Output |
|---|---|
| **VGA Display** | Start menu, active gameplay, game-over screen |
| **OLED Display** | Real-time score / point system |
| **7-Segment Display** | Remaining reroll count |
| **Speaker** | Continuous background game music |
| **LEDs 1–15** | Blink at current block fall speed; all ON at game-over, all OFF on start page |

---

## System Architecture

### Block Fall Speed (score-based)

| Score Range | Fall Speed |
|---|---|
| < 50 | 1 Hz |
| 50 – 99 | 2 Hz |
| 100 – 149 | 2.5 Hz |
| ≥ 150 | 3 Hz |

> Pressing `btnD` temporarily increases fall speed to **5 Hz**.

### Key Hardware Modules

- **Graphics & VGA** — pixel mapping, state-based screen rendering, unique RGB colour encoding per block type
- **Collision Detection** — logic flag system to trigger new block spawning upon collision
- **Grid Memory** — 200-bit memory design for block placement and overwriting
- **Line Clearing** — 2-bit state transition logic for clearing and shifting rows
- **LFSR (4-bit)** — pseudo-random block selection
- **Reroll Logic** — replaces active block on button press, decrements reroll counter
- **OLED Controller** — real-time score update display
- **Music Module** — frequency and duration-tuned notes for continuous background music
- **Button Debouncing** — input mapping for all player controls
- **Priority Encoder** — selects initial reroll count from switches 1–15

---

## Team & Contributions

| Member | Responsibilities |
|---|---|
| **Ng Xi** | Graphics logic, VGA screen design, block rendering, game-over screen, priority encoder, 7-segment reroll display |
| **Le Minh Hieu** | Collision detection, 200-bit grid memory, line clearing & block shifting, boundary enforcement |
| **Than The Cong** | 4-bit LFSR, OLED score display, background music, grid memory & collision support |
| **Renu Deepa Laxmi** | Block spawning & fall logic, button debouncing, boundary checks, speed-based LED indicators, VGA rendering support |

---

## References

### Hardware Documentation
- [Digilent Basys3 FPGA Reference Manual](https://digilent.com/reference/basys3/refmanual#vga_port)

### Open Source References
- [VGA Controller Example in Verilog](https://github.com/BlagojeBlagojevic/vga_verilog) — referenced for VGA timing and structure (no direct code reuse)
- [Tetris Theme Song – Arduino Implementation](https://github.com/robsoncouto/arduino-songs/blob/master/tetris/tetris.ino) — referenced for melody, note frequency, and duration

### Verilog / HDL Resources
- [For Loop Usage in Verilog – Logic Fruit](https://www.logic-fruit.com/blog/high-speed-interface/for-loop-in-verilog/)
- [Verilog Net Types – ChipVerify](https://www.chipverify.com/verilog/verilog-net-types)
- [Verilog Generate Blocks – ChipVerify](https://www.chipverify.com/verilog/verilog-generate-block)
- [Reduction Operators in Verilog – Nandland](https://nandland.com/reduction-operators/)

### Video Tutorials
- [Button Debouncing and Edge Detection](https://www.youtube.com/watch?v=2dgFvj3WwXk)
- [Speaker and Audio Signal Generation on FPGA](https://www.youtube.com/watch?v=AX5nIfmVcrg)

### AI Tools Used (Declared)
- **Google Gemini** — title screen layout ideas; IP handler conceptual reference
- **Anthropic Claude** — technical explanation refinement; score display conceptual reference

---

*Team S6_12 — EE2026 FPGA Project*
