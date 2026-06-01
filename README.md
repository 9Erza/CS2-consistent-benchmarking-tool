# CS2 Consistent Benchmarking Tool

A lightweight and reproducible automation tool for benchmarking Counter-Strike 2 performance.

This project uses an external AutoHotkey script to launch CS2, load a specific Steam Workshop benchmark map, and trigger FPS/frametime capture in CapFrameX.

## Purpose

Most CS2 players know that workshop benchmark maps, such as **CS2 FPS Benchmark** on Dust 2, usually do not represent the exact FPS you can expect during real competitive matches. In most cases, benchmark results are higher than the performance seen in Premier or Faceit matches.

The main goal of this tool is not to perfectly simulate a real match, but to provide **consistent and repeatable benchmark results**.

By combining a fixed workshop map, an AutoHotkey automation script, and CapFrameX, this tool makes it easier to compare performance changes between different:

- graphics settings,
- Windows optimizations,
- driver versions,
- BIOS or system tweaks,
- hardware configurations.

This consistency helps identify which changes actually improve performance and which ones only appear to make a difference.

## Background and Credits

This repository was inspired by the **CS2 Benchmark Automation** project created by [Ark0N](https://github.com/Ark0N):

[Ark0N/-CS2-Benchmark-Automation](https://github.com/Ark0N/-CS2-Benchmark-Automation)

In my case, the original bundle and scripts did not work correctly. Because of that, I decided to create a cleaner version based on official software releases and a dedicated `.ahk` script designed to be simple, reliable, and easy to use.

## Requirements

Before using this tool, install and prepare the following software:

### AutoHotkey

Required to run the automation script. AutoHotkey v2 is recommended.

Download: [autohotkey.com](https://www.autohotkey.com/)

### CapFrameX

Used for capturing and analyzing FPS and frametime data.

Download: [capframex.com](https://www.capframex.com/)

### Steam Workshop Map

Subscribe to the benchmark map used by the script:

[CS2 FPS Benchmark](https://steamcommunity.com/workshop/filedetails/?id=3240880604)

## Configuration

### CapFrameX Setup

1. Open CapFrameX.
2. Go to the **Capture** tab.
3. Set **Capture time** to exactly **102 seconds**.
4. Make sure the capture hotkey is set to **F5**.

The script uses **F5** to start the CapFrameX capture automatically.

### AutoHotkey Script

The `cs2_benchmark.ahk` script is designed to work out of the box.

It automatically reads the Steam installation path from the Windows Registry, so no manual path editing should be required.

You can find the script here:

- [View Source on GitHub](https://github.com/9Erza/CS2-consistent-benchmarking-tool/blob/main/cs2_benchmark.ahk)
- [Download Raw Script](https://raw.githubusercontent.com/9Erza/CS2-consistent-benchmarking-tool/refs/heads/main/cs2_benchmark.ahk)

## Usage

1. Make sure Steam is running.
2. Launch CapFrameX in the background.
3. Run the `cs2_benchmark.ahk` file.

## How It Works

After running the script:

1. CS2 is launched with the developer console enabled.
2. The script automatically enters the following command:

   ```text
   map_workshop 3240880604
