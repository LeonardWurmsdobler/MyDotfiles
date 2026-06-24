#!/usr/bin/env python3
import subprocess
import json

IGNORE_CLASSES = {
    "", "waybar", "hyprlock", "hypridle",
    "xdg-desktop-portal", "xdg-desktop-portal-hyprland",
    "xdg-desktop-portal-gtk", "nm-applet", "blueman-applet",
    "dunst", "mako", "swww-daemon", "swaybg", "wl-paste",
    "polkit-gnome-authentication-agent-1", "gcr-prompter",
    "xdg-permission-store", "gsd-media-keys",
}

ICONS = {
    "firefox": "",
    "chromium": "",
    "google-chrome": "",
    "brave-browser": "",
    "com.mitchellh.ghostty": "󰆍",
    "kitty": "",
    "alacritty": "",
    "foot": "",
    "wezterm-gui": "",
    "code": "",
    "code-oss": "",
    "pycharm": "",
    "pycharm-professional": "",
    "steam": "",
    "com.valvesoftware.steam": "",
    "lutris": "",
    "heroic": "",
    "discord": "󰙯",
    "vesktop": "󰙯",
    "telegram-desktop": "",
    "slack": "",
    "spotify": "",
    "vlc": "󰕼",
    "mpv": "",
    "obs": "",
    "com.obsproject.studio": "",
    "gimp-2.10": "",
    "gimp": "",
    "inkscape": "",
    "blender": "󰂫",
    "thunar": "",
    "nautilus": "",
    "dolphin": "",
    "obsidian": "󰹕",
    "libreoffice-writer": "",
    "libreoffice-calc": "",
    "libreoffice-impress": "",
    "soffice": "󰏆",
    "onlyoffice-desktopeditors": "󰏆",
    "evince": "",
    "zathura": "",
    "eog": "",
    "qbittorrent": "",
    "filezilla": "",
    "virt-manager": "",
    "prismlauncher": "⛏",
    "minecraft-launcher": "⛏",
}

DISPLAY_NAMES = {
    "com.mitchellh.ghostty": "Ghostty",
    "com.valvesoftware.steam": "Steam",
    "com.obsproject.studio": "OBS",
    "telegram-desktop": "Telegram",
    "code-oss": "VS Code",
    "pycharm-professional": "PyCharm",
    "onlyoffice-desktopeditors": "OnlyOffice",
    "wezterm-gui": "WezTerm",
    "gimp-2.10": "GIMP",
    "prismlauncher": "Prism Launcher",
    "minecraft-launcher": "Minecraft",
    "libreoffice-writer": "LibreOffice Writer",
    "libreoffice-calc": "LibreOffice Calc",
    "libreoffice-impress": "LibreOffice Impress",
}

def display_name(cls):
    if cls in DISPLAY_NAMES:
        return DISPLAY_NAMES[cls]
    return cls.split(".")[-1].capitalize()

def main():
    try:
        result = subprocess.run(
            ["hyprctl", "clients", "-j"],
            capture_output=True, text=True, timeout=2
        )
        clients = json.loads(result.stdout)
    except Exception:
        print(json.dumps({"text": "", "tooltip": "hyprctl error", "class": "error"}))
        return

    seen = {}
    for client in clients:
        cls = client.get("class", "").lower()
        title = client.get("title", "")
        if cls in IGNORE_CLASSES:
            continue
        if cls not in seen:
            seen[cls] = {"titles": [title], "count": 1}
        else:
            seen[cls]["count"] += 1
            seen[cls]["titles"].append(title)

    if not seen:
        print(json.dumps({"text": "", "tooltip": "No apps running", "class": "empty"}))
        return

    text_parts = []
    tooltip_lines = []
    for cls, info in seen.items():
        icon = ICONS.get(cls, "󰘔")
        name = display_name(cls)
        text_parts.append(icon)
        if info["count"] > 1:
            tooltip_lines.append(f"{icon} {name} ×{info['count']}")
        else:
            short = info["titles"][0][:45] if info["titles"][0] else name
            tooltip_lines.append(f"{icon} {name}: {short}")

    print(json.dumps({
        "text": "  ".join(text_parts),
        "tooltip": "\n".join(tooltip_lines),
        "class": "running",
    }))

if __name__ == "__main__":
    main()
