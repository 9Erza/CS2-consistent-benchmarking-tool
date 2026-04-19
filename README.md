# CS2 Consistent Benchmarking Tool

A simple and 100% reproducible tool for automating the benchmarking process in Counter-Strike 2. This project uses an external AutoHotkey script to launch the game, load a specific Steam Workshop map, and trigger framerate capture in CapFrameX.

## 💡 Why this tool?

As most CS2 players are aware, workshop benchmarks like "CS2 FPS Benchmark" (Dust 2) do not show the exact FPS you can expect in real competitive matches. Generally, the benchmark results are higher than those seen in Premier or Faceit matches.

However, the primary goal of this tool is **consistency**. By using this specific workshop map combined with the AutoHotkey script and CapFrameX, you can achieve highly reproducible performance results. This consistency is crucial for accurately evaluating which graphics settings, Windows tweaks, or hardware changes actually improve performance, allowing for precise and effective game optimization.

## 🛠️ Background & Credits

The main inspiration for this repository was the **CS2 Benchmark Automation** project by [Ark0N](https://github.com/Ark0N) (link: [Ark0N/-CS2-Benchmark-Automation](https://github.com/Ark0N/-CS2-Benchmark-Automation)). 

In my case, the original bundle and scripts did not function correctly. I decided to build a cleaner version using official software versions and a `.ahk` script designed to be reliable and easy to use.

## ⚙️ Requirements

To use this tool correctly, install and prepare the following:

1. **AutoHotkey (AHK)** – Required to run the automation script (v2 recommended). Download: [autohotkey.com](https://www.autohotkey.com/)
2. **CapFrameX** – Software for capturing and analyzing frametimes/FPS. Download: [capframex.com](https://www.capframex.com/)
3. **Steam Workshop Map** – Subscribe to the benchmark map used by the script:
   * [CS2 FPS Benchmark](https://steamcommunity.com/workshop/filedetails/?id=3240880604)

## 🔧 Configuration

### CapFrameX Setup
1. Open CapFrameX and go to the **Capture** tab.
2. Set **Capture time** to exactly **102 seconds**.
3. Ensure your capture Hotkey is set to **F5** (the default used by the script).

### AHK Script
The `cs2_benchmark.ahk` script works "out of the box." It automatically fetches your Steam installation path from the Windows Registry, so no manual path editing is required.

## 🚀 Usage

1. Ensure Steam is running.
2. Launch CapFrameX in the background.
3. Run the `cs2_benchmark.ahk` file.

**What happens next?**
* The script launches CS2 with the developer console enabled.
* Once the game loads, it automatically enters the command `map_workshop 3240880604`.
* After a brief loading buffer, the script plays two beeps and triggers the **F5** key to start the CapFrameX capture.
* It runs for 102 seconds (100s for the test + 2s for file saving) and then automatically closes the game using the `quit` command.
