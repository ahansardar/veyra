<h1 align="center">Veyra</h1>

<h4 align="center">Veyra is an open source anti-detect browser built for webscraping & AI agents.</h4>

<div align="center">
  <a href="https://pepy.tech/projects/veyra"><img src="https://static.pepy.tech/personalized-badge/veyra?period=total&units=INTERNATIONAL_SYSTEM&left_color=BLACK&right_color=GREEN&left_text=downloads" alt="Total Downloads"</a>
  <a href="https://pepy.tech/projects/veyra"><img src="https://static.pepy.tech/personalized-badge/veyra?period=monthly&units=INTERNATIONAL_SYSTEM&left_color=BLACK&right_color=GREEN&left_text=downloads%2Fmonth" alt="Monthly Downloads"></a>
    <a href="https://pepy.tech/projects/veyra"><img src="https://static.pepy.tech/personalized-badge/veyra?period=weekly&units=INTERNATIONAL_SYSTEM&left_color=BLACK&right_color=GREEN&left_text=downloads%2Fweek" alt="Weekly Downloads"></a>
<h4>⚠️ This project is under development. It may not be suitable for stable production use. ⚠️</h4>
</div>

---

# Introduction

Veyra is a Firefox fork engineered for web scraping and AI agents. It is headless, undetectable, and optimized to run at scale. Every run gets a fresh identity drawn from the real-world distribution of devices, so it blends into normal traffic instead of standing out.

## Highlights

* **Built for AI agents** 🤖
  * Minimal, debloated Firefox - fast to launch, cheap to run
  * Drop-in Playwright compatibility via Python interface
  * Invisible to anti-bot systems so you can run your agent cluster locally or in the cloud without being flagged

- **Undetectable by design** 🎭
  - Page automation hidden from JavaScript inspection. See the [stealth page](https://veyra.example.com/stealth) for more details.

* **Fingerprint injection & rotation (without JS injection!)**
  * All navigator properties (device, OS, hardware, browser, etc.) ✅
  * Screen size, resolution, window, & viewport properties ✅
  * Geolocation, timezone, locale, & Intl spoofing ✅
  * WebRTC IP spoofing at the protocol level ✅
  * Voices, speech playback rate, etc. ✅
  * And much, much more!

- **Anti Graphical fingerprinting**
  - WebGL parameters, supported extensions, context attributes, & shader precision formats ✅
  - Font spoofing & anti-fingerprinting ✅

* **Optimized for automation**
  * Human-like mouse movement 🖱️
  * Blocks & circumvents ads 🛡️
  * No CSS animations 💨

- Debloated & optimized for memory efficiency ⚡
- [PyPi package](https://pypi.org/project/veyra/) for updates & auto fingerprint injection 📦
- Stays up to date with the latest Firefox version 🕓

---

## Fingerprint Injection

In Veyra, data is intercepted at the C++ implementation level, making the changes undetectable through JavaScript inspection.

To spoof individual fingerprint properties, pass a JSON containing properties to spoof to the [Python interface](https://github.com/ahansardar/veyra/tree/main/pythonlib#veyra-python-interface):

```py
>>> with Veyra(config={"property": "value"}) as browser:
```

Config data not set by the user will be automatically populated using [BrowserForge](https://github.com/daijro/browserforge) fingerprints, which mimic the statistical distribution of device characteristics in real-world traffic.

[[See implemented properties](https://veyra.example.com/fingerprint/)]

---

## Python Usage

Veyra is compatible with your existing Playwright code. You only have to change your browser initialization.

**Sync API**

```python
from veyra.sync_api import Veyra

with Veyra() as browser:
    page = browser.new_page()
    page.goto("https://example.com")
```

**Async API**

```python
from veyra.async_api import AsyncVeyra

async with AsyncVeyra() as browser:
    page = await browser.new_page()
    await page.goto("https://example.com")
```

[[Installation & usage](https://veyra.example.com/python/)]

---

## Capabilities

Below is a list of patches and features implemented in Veyra.

### Fingerprint spoofing

- Navigator properties spoofing (device, browser, locale, etc.)
- Support for emulating screen size, resolution, etc.
- Spoof WebGL parameters, supported extensions, context attributes, and shader precision formats.
- Spoof inner and outer window viewport sizes
- Spoof AudioContext sample rate, output latency, and max channel count
- Spoof device voices & playback rates
- Spoof the amount of microphones, webcams, and speakers available.
- Network headers (Accept-Languages and User-Agent) are spoofed to match the navigator properties
- WebRTC IP spoofing at the protocol level
- Geolocation, timezone, and locale spoofing
- Battery API spoofing
- etc.

### Stealth patches

- Avoids main world execution leaks. All page agent javascript is sandboxed
- Avoids frame execution context leaks
- Fixes `navigator.webdriver` detection
- Fixes Firefox headless detection via pointer type ([#26](https://github.com/daijro/camoufox/issues/26))
- Removed potentially leaking anti-zoom/meta viewport handling patches
- Uses non-default screen & window sizes
- Re-enable fission content isolations
- Re-enable PDF.js
- Other leaking config properties changed
- Human-like cursor movement

### Anti font fingerprinting

- Automatically uses the correct system fonts for your User Agent
- Bundled with Windows, Mac, and Linux system fonts
- Prevents font metrics fingerprinting by randomly offsetting letter spacing

### Playwright support

- Custom implementation of Playwright for the latest Firefox
- Various config patches to evade bot detection

### Debloat/Optimizations

- Stripped out/disabled _many, many_ Mozilla services. Runs faster than the original Mozilla Firefox, and uses less memory (200mb)
- Patches from LibreWolf & Ghostery to help remove telemetry & bloat
- Debloat config from PeskyFox, LibreWolf, and others
- Speed & network optimizations from FastFox
- Removed all CSS animations
- Minimalistic theming
- etc.

### Addons

- Load Firefox addons without a debug server by passing a list of paths to the `addons` property
- Added uBlock Origin with custom privacy filters
- Addons are not allowed to open tabs
- Addons are automatically enabled in Private Browsing mode
- Addons are automatically pinned to the toolbar
- Fixes DNS leaks with uBO prefetching

### Python Interface

- Automatically generates & injects unique device characteristics into Veyra based on their real-world distribution
- WebGL fingerprint injection & rotation
- Uses the correct system fonts and subpixel antialiasing & hinting based on your target OS
- Avoid proxy detection by calculating your target geolocation, timezone, & locale from your proxy's target region
- Calculate and spoof the browser's language based on the distribution of language speakers in the proxy's target region
- Remote server hosting to use Veyra with other languages that support Playwright
- Built-in virtual display buffer to run Veyra headfully on a headless server
- Toggle image loading, WebRTC, and WebGL
- etc.

> [!NOTE]
> Veyra does **not** fully support injecting Chromium fingerprints. Some WAFs (such as [Interstitial](https://nopecha.com/demo/cloudflare)) test for Spidermonkey engine behavior, which is impossible to spoof.

---

# Stealth Overview

## How Veyra hides its automation library

> [!WARNING]
> **Current status as of 2026**:
> There has been a year gap in maintenance due to a personal situation. Veyra has gone down in performance due to the base Firefox version and newly discovered fingerprint inconsistencies. **Veyra is currently under active development.**

In Veyra, all of Playwright's internal Page Agent's code is sandboxed and isolated. This makes it impossible for a page to detect the presence of Playwright through Javascript inspection.

Normally, Playwright injects some JavaScript into the page such as `window.__playwright__binding__` and to perform actions like querying elements, evaluating javascript, or running init scripts, which can be detected by websites. In Veyra, these actions are handled in an isolated scope outside of the page. In other words, websites can no longer "see" any JavaScript that Playwright would typically inject. This prevents traces of Playwright altogether.

However, even with hiding its automation library, Veyra is not immune to inconsistencies in fingerprint rotation. This still requires maintenance to spot and fix.

### Page Interactions

Anti-bot systems also run client-side scripts to monitor your behavior. For example, they look for patterns in mouse movements, clicks, scrolling, and the timing between actions.

<video src="https://github.com/user-attachments/assets/6d33d6af-3537-4603-bf24-6bd3f4f8f455" width="200px" autoplay loop muted></video>

Veyra tries its best with its human-like mouse movement algorithm. The natural motion algorithm was originally from [riflosnake's HumanCursor](https://github.com/riflosnake/HumanCursor) and has been rewritten in C++ and modified for more distance-aware trajectories.

However, this isn't perfect. It may still be detected with sophisticated enough analysis. (WIP for the future)

---

## How Veyra rotates identities

AI agents need to operate across many sessions without getting flagged or rate-limited. Rotating your IP address isn't enough — every browser session carries thousands of signals that create a unique **fingerprint**. A website can see your OS, GPU, screen resolution, fonts, timezone, and more. If those signals are inconsistent or unusual, you get blocked.

### Market Share Distribution

Even if you are rotating your IP for each running bot instance, web access firewalls can still use machine learning to analyze incoming web traffic to detect if it's abnormal. If the Linux market share was 5%, then suddenly it's 20%, it's a red flag. They will unconditionally require all Linux users to complete a captcha.

Veyra uses [BrowserForge](https://github.com/daijro/browserforge)'s fingerprint generator to mimic the statistical distribution of device data in real-world traffic. For example, Veyra will make your browser look like a Linux user 5% of the time. Of that 5%, it will spoof a 2560x1440 screen resolution 9.5% of the time and an Intel HD GPU 27.5% of the time.

### How can Veyra be detected?

Veyra can spoof fingerprints with a correct market share. However, **fingerprints must also be internally consistent.** A Windows user agent with an Apple M1 GPU, a MacOS user agent with a Windows DirectX renderer, and a mobile device with a desktop screen resolution are all impossible, and will be flagged for being suspicious.

Of the thousands of possible datapoints that must be changed to create a believable spoofed fingerprint, where each change must be consistent with the others, Veyra doesn't always succeed. Anti-bot providers test Veyra over and over again to find even 1 unique inconsistency, then they immediately update their background scripts to test for it.

---

## How does Veyra compare to other solutions?

### JavaScript-based solutions

In the past, developers tried injecting JavaScript to spoof these values, but it doesn't work reliably since JavaScript can't spoof everything. Incomplete coverage causes inconsistent fingerprints. For example, an anti-bot system will flag you if your network request's User Agent doesn't match your navigator's User Agent.

Additionally, all injected JavaScript is detectable in some way. Anti-bot systems can check if `Object.getOwnPropertyDescriptor` reveals an overwritten property, if a function's `toString()` no longer returns `[native code]` (revealing it was hijacked), or if data in the window context doesn't match the worker thread context. Workarounds only take you so far, but there will always be a way to detect JS injection if you search deep enough.

#### Veyra's approach

Since Veyra intercepts calls in the browser's C++ implementation level, all of the hijacked objects and properties appear native. There is no JavaScript hijacking to be detected.

Veyra also attempts to generate consistent and believable fingerprints with Browserforge as well. However, this can still be detected by complex fingerprint detection methods like mismatching data (as described earlier).

<hr width=50>

### CDP-based libraries

CDP (Chrome DevTools Protocol) is an automation protocol built into Chromium and Firefox. However, CDP makes no effort to hide the fact that it's an automation protocol and exposes much of its functionality in the page scope. Some common methods are checking if `navigator.webdriver` is true, catching it reading the stack debugger, checking for variables that ChromeDriver injects into the document object for internal communication, and more.

#### Veyra's approach

While Playwright uses CDP to control Chromium, it uses _Juggler_ for Firefox. Juggler is a custom protocol developed before Firefox supported CDP ([original repo](https://github.com/puppeteer/juggler)). It is a distinct module within Firefox, and not part of its core browser. This makes it easier to edit and control what's revealed to the page.

Veyra patches Juggler to give it its own isolated "copy" of the page to work with. Playwright can read and edit its own version of the page freely. Everything appears to work normally to it, but the real page is completely unaffected by these changes. The page also can't detect when things are being read (through tricks like hijacking getters) or listeners being added to watch elements.

Additionally, Juggler sends its inputs directly through the Firefox's original user input handlers, meaning they are handled the exact same way as if you were using the browser normally. Veyra also patches Firefox's headless mode to appear the same as if it were running in a normal window. But as a fallback, the Python library can run Veyra in a [virtual display](https://veyra.example.com/python/virtual-display/) if headless mode ever leaks.

---

<h1 align="center">Build System</h1>

> [!WARNING]
> The content below is intended for those interested in building & debugging Veyra. For Playwright usage instructions, see [here](https://github.com/ahansardar/veyra/tree/main/pythonlib#veyra-python-interface).

### Overview

Here is a diagram of the build system, and its associated make commands:

```mermaid
graph TD
    FFSRC[Firefox Source] -->|make fetch| REPO

    subgraph REPO[Veyra Repository]
        PATCHES[Fingerprint masking patches]
        ADDONS[uBlock & B.P.C.]
        DEBLOAT[Debloat/optimizations]
        SYSTEM_FONTS[Win, Mac, Linux fonts]
        JUGGLER[Patched Juggler]
    end

    subgraph Local
    REPO -->|make dir| PATCH[Patched Source]
    PATCH -->|make build| BUILD[Built]
    BUILD -->|make package-linux| LINUX[Linux Portable]
    BUILD -->|make package-windows| WIN[Windows Portable]
    BUILD -->|make package-macos| MAC[macOS Portable]
    end
```

This was originally based on the LibreWolf build system.

## Build CLI

> [!WARNING]
> Veyra's build system is designed to be used in Linux. WSL will not work!

First, clone this repository with Git:

```bash
git clone --depth 1 https://github.com/ahansardar/veyra
cd veyra
```

Next, build the Veyra source code with the following command:

```bash
make dir
```

Before bootstrapping, install the system build dependencies with the helper
script. It detects your platform and installs everything the build needs
(Python ≥ 3.11, Rust, `aria2`, `p7zip`, `go`, `msitools`, `wget`, `sqlite`, and
the core build tools) using the appropriate package manager — Homebrew on macOS,
or `apt`/`dnf`/`pacman` on Linux:

```bash
bash scripts/install-deps.sh
```

> [!NOTE]
> The dependency installer has so far only been tested on macOS.

After that, you have to bootstrap your system to be able to build Veyra. You only have to do this one time. It is done by running the following command:

```bash
make bootstrap
```

Finally you can build and package Veyra the following command:

```bash
python3 multibuild.py --target linux windows macos --arch x86_64 arm64 i686
```

For new builds, `i686` is supported only for Windows. Unsupported target/architecture combinations are skipped.

<details>
<summary>
CLI Parameters
</summary>

```bash
Options:
  -h, --help            show this help message and exit
  --target {linux,windows,macos} [{linux,windows,macos} ...]
                        Target platforms to build
  --arch {x86_64,arm64,i686} [{x86_64,arm64,i686} ...]
                        Target architectures to build for each platform
  --bootstrap           Bootstrap the build system
  --clean               Clean the build directory before starting

Example:
$ python3 multibuild.py --target linux windows macos --arch x86_64 arm64
```

</details>

### Using Docker

Veyra can be built through Docker on all platforms.

1. Create the Docker image containing Firefox's source code:

```bash
docker build -t veyra-builder .
```

2. Build Veyra patches to a target platform and architecture:

```bash
docker run -v "$(pwd)/dist:/app/dist" veyra-builder --target <os> --arch <arch>
```

<details>
<summary>
How can I use my local ~/.mozbuild directory?
</summary>

If you want to use the host's .mozbuild directory, you can use the following command instead to run the docker:

```bash
docker run \
  -v "$HOME/.mozbuild":/root/.mozbuild:rw,z \
  -v "$(pwd)/dist:/app/dist" \
  veyra-builder \
  --target <os> \
  --arch <arch>
```

</details>

<details>
<summary>
Docker CLI Parameters
</summary>

```bash
Options:
  -h, --help            show this help message and exit
  --target {linux,windows,macos} [{linux,windows,macos} ...]
                        Target platforms to build
  --arch {x86_64,arm64,i686} [{x86_64,arm64,i686} ...]
                        Target architectures to build for each platform
  --bootstrap           Bootstrap the build system
  --clean               Clean the build directory before starting

Example:
$ docker run -v "$(pwd)/dist:/app/dist" veyra-builder --target windows macos linux --arch x86_64 arm64 i686
```

</details>

Build artifacts will now appear written under the `dist/` folder.

---

## Development Tools

This repo comes with a developer UI under scripts/developer.py:

```
make edits
```

Patches can be edited, created, removed, and managed through here.

<img src="https://i.imgur.com/BYAN5J0.png">

### How to make a patch

1. In the developer UI, click **Reset workspace**.
2. Make changes in the `veyra-*/` folder as needed. You can test your changes with `make build` and `make run`.
3. After you're done making changes, click **Write workspace to patch** and save the patch file.

### How to work on an existing patch

1. In the developer UI, click **Edit a patch**.
2. Select the patch you'd like to edit. Your workspace will be reset to the state of the selected patch.
3. After you're done making changes, hit **Write workspace to patch** and overwrite the existing patch file.

---

## Leak Debugging

This is a flow chart demonstrating my process for determining leaks without deobfuscating WAF Javascript. The method incrementally reintroduces Veyra's features into Firefox's source code until the testing site flags.

This process requires a Linux system and assumes you have Firefox build tools installed (see [here](https://github.com/ahansardar/veyra?tab=readme-ov-file#build-cli)).

<details>
<summary>
See flow chart...
</summary>

```mermaid
flowchart TD
    A[Start] --> B[Does website flag in the official Firefox?]
    B -->|Yes| C[Likely bad IP/rate-limiting. If the website fails on both headless and headful mode on the official Firefox distribution, the issue is not with the browser.]
    B -->|No| D["Run make ff-dbg(1) and build(2) a clean distribution of Firefox. Does the website flag in Firefox **headless** mode(4)?"]
    D -->|Yes| E["Does the website flag in headful mode(3) AND headless mode(4)?"]
    D -->|No| F["Open the developer UI(5), apply config.patch, then rebuild(2). Does the website still flag(3)?"]
    E -->|No| G["Enable privacy.resistFingerprinting in the config(6). Does the website still flag(3)?"]
    E -->|Yes| C
    G -->|No| H["In the config(6), enable FPP and start omitting overrides until you find the one that fixed the leak."]
    G -->|Yes| I[If you get to this point, you may need to deobfuscate the Javascript behind the website to identify what it's testing.]
    F -->|Yes| K["Open the developer UI, apply the playwright bootstrap patch, then rebuild. Does it still flag?"]
    F -->|No| J["Omit options from veyra.cfg(6) and rerun(3) until you find the one causing the leak."]
    K -->|No| M[Juggler needs to be debugged to locate the leak.]
    K -->|Yes| L[The issue has nothing to do with Playwright. Apply the rest of the Veyra patches one by one until the one causing the leak is found.]
    M --> I
```

#### Cited Commands

| #   | Command                                       | Description                                                                                                 |
| --- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| (1) | `make ff-dbg`                                 | Setup vanilla Firefox with minimal patches.                                                                 |
| (2) | `make build`                                  | Build the source code.                                                                                      |
| (3) | `make run`                                    | Runs the built browser.                                                                                     |
| (4) | `make run args="--headless https://test.com"` | Run a URL in headless mode. All redirects will be printed to the console to determine if the test passed.   |
| (5) | `make edits`                                  | Opens the developer UI. Allows the user to apply/undo patches, and see which patches are currently applied. |
| (6) | `make edit-cfg`                               | Edit veyra.cfg in the default system editor.                                                             |

</details>

