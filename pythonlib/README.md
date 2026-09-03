<div align="center">

# Veyra Python Interface

#### Lightweight wrapper around the Playwright API to help launch Veyra.

</div>

> [!NOTE]
> All the the latest documentation is avaliable [here](https://veyra.example.com/python).

---

## What is this?

This Python library wraps around Playwright's API to help automatically generate & inject unique device characteristics (OS, CPU info, navigator, fonts, headers, screen dimensions, viewport size, WebGL, addons, etc.) into Veyra.

It uses [BrowserForge](https://github.com/daijro/browserforge) under the hood to generate fingerprints that mimic the statistical distribution of device characteristics in real-world traffic.

In addition, it will also calculate your target geolocation, timezone, and locale to avoid proxy protection ([see demo](https://i.imgur.com/UhSHfaV.png)).

---

## Installation

First, install the `veyra` package:

```bash
pip install -U veyra[geoip]
```

The `geoip` parameter is optional, but heavily recommended if you are using proxies. It will download an extra dataset to determine the user's longitude, latitude, timezone, country, & locale.

Next, download the Veyra browser:

**Windows**

```bash
veyra fetch
```

**MacOS & Linux**

```bash
python3 -m veyra fetch
```

To uninstall, run `veyra remove`.

---

# Installing multiple Veyra versions & from other repos

## UI Manager

Manage installed browsers, active version, IP geolocation databases, and package info. Basically a Qt front end for the Python CLI tool.

More updates on it will be coming soon.

<hr width=50>

To use the gui, install Veyra with the `[gui]` extra:

```bash
pip install 'veyra[gui]'
```

To launch:

```bash
veyra gui
```

---

## CLI Mananger

#### Demonstration

https://github.com/user-attachments/assets/992b1830-6b21-4024-9165-728854df1473

<details>
<summary>See help message</summary>

```
$ python -m veyra --help

 Usage: python -m veyra [OPTIONS] COMMAND [ARGS]...

╭─ Options ─────────────────────────────────────────────────────────────────────────────╮
│ --help  Show this message and exit.                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ────────────────────────────────────────────────────────────────────────────╮
│ active    Print the current active version                                            │
│ fetch     Install the active version, or a specific version                           │
│ gui       Launch the Veyra Manager GUI (requires PySide6)                          │
│ list      List Veyra versions                                                      │
│ path      Print the install directory path                                            │
│ remove    Remove downloaded data. By default, this removes everything.                │
│           Pass --select to pick a browser version to remove.                          │
│ server    Launch a Playwright server                                                  │
│ set       Set the active Veyra version to use & fetch.                             │
│           By default, this opens an interactive selector for versions and settings.   │
│           You can also pass a specifier to activate directly:                         │
│           Pin version:                                                                │
│               veyra set official/stable/134.0.2-beta.20                            │
│           Automatically find latest in a channel source:                              │
│               veyra set official/stable                                            │
│ sync      Sync available versions from remote repositories                            │
│ test      Open the Playwright inspector                                               │
│ version   Display version, package, browser, and storage info                         │
╰───────────────────────────────────────────────────────────────────────────────────────╯
```

</details>

### `sync`

Pull a list of release assets from GitHub.

```bash
> veyra sync
Syncing repositories...
  Official... 24 versions
  CoryKing... 2 versions

Synced 26 versions from 2 repos.
```

<hr width=50>

### `set`

Choose a version channel or pin a specific version. Can also be called with a specifier to activate directly.

Interactive selector:

```bash
> veyra set
```

You can also pass a specifier to pin a specific version or choose a channel to follow directly. This will pull the latest stable version from the official repo on `veyra fetch`.

```bash
> veyra set official/stable  # Default setting
```

Follow latest prerelease version from the official repo, if applicable:

```bash
> veyra set official/prerelease
```

Pin a specific version:

```bash
> veyra set official/stable/134.0.2-beta.20
```

<hr width=50>

### `active`

Prints the current active version string:

```bash
> veyra active  # Default channel is active
official/stable
```

```bash
> veyra set coryking/stable/142.0.1-fork.26
Pinned: coryking/stable/142.0.1-fork.26
Run 'veyra fetch' to install.

> veyra active  # A specific version is pinned
coryking/stable/142.0.1-fork.26 (not installed)
```

<hr width=50>

### `fetch`

Install the latest version from the active channel. By default, this is official/stable. This will also automatically sync repository assets.

```bash
> veyra fetch  # Install the latest in the channel
```

To download the latest from a different channel, or pin a version:

```bash
> veyra set coryking/stable
> veyra fetch  # Will download the latest release from CoryKing's repo for now on
```

Or pass in the identifier to download directly without activating it:

```bash
> veyra fetch official/stable/135.0-beta.25   # Install a specific version
```

<hr width=50>

### `list`

List installed or all available Veyra versions as a tree.

```bash
> veyra list          # show installed versions
> veyra list all      # show all available versions from synced repos
> veyra list --path   # show full install paths
```

<hr width=50>

### `remove`

By default, removes the entire veyra data directory.

```bash
> veyra remove
> veyra remove -y  # skip confirmation prompt
```

Remove a specific version:

```bash
> veyra remove official/stable/134.0.2-beta.20
```

Interactively select a version to remove:

```bash
> veyra remove --select
```

<hr width=50>

### `version`

Display the Python package version, active browser version, channel, and update status.

```bash
> veyra version
Python Packages
  Veyra                    v0.5.0
  Browserforge                v1.2.4
  Apify Fingerprints          v0.10.0
  Playwright                  v1.57.1.dev0+g732639b35.d20251217
Browser
  Active                      official/stable/135.0.1-beta.24
  Current browser             v135.0.1-beta.24
  Installed                   Yes
  Latest in official/stable?  Yes
  Last Sync                   2026-03-07 00:23
GeoIP
  Database                    MaxMind GeoLite2
  Updated                     2026-03-07 00:24
Storage
  Install path                /home/name/.cache/veyra
  Browser(s) directory size   1.2 GB
  GeoIP database size         40.7 MB
  Config file                 /home/name/.cache/veyra/config.json
  Repo cache                  /home/name/.cache/veyra/repo_cache.json
```

<hr width=50>

### `path`

Print the install directory path.

```bash
> veyra path
/home/name/.cache/veyra
```

<hr width=50>

### `test`

Open Veyra with the Playwright inspector for debugging.

```bash
> veyra test
> veyra test https://example.com
```

<hr width=50>

### `server`

Launch a remote Playwright server.

```bash
> veyra server
```

---

## Usage

All of the latest stable documentation is avaliable at [veyra.example.com/python](https://veyra.example.com/python).
