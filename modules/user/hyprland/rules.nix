{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.userSettings.hyprland;
  font = config.stylix.fonts.monospace.name;
  term = config.userSettings.terminal;
  spawnEditor = config.userSettings.spawnEditor;
  spawnBrowser = config.userSettings.spawnBrowser;
  performance = config.userSettings.hyprland.performanceOptimizations;
in
{

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      # Window rules
      windowrule = [
        # Opacity
        "opacity 0.95 override, match:fullscreen false"

        # Opaque windows (native transparency or forced opaque)
        "opaque true, match:class foot|equibop|org\.quickshell|imv|swappy"

        # Center floating windows (not xwayland because of popups)
        "center true, match:float true, match:xwayland false"

        # Float rules
        "float true, match:class guifetch"  # FlafyDev/guifetch
        "float true, match:class yad"
        "float true, match:class zenity"
        "float true, match:class wev"
        "float true, match:class org\.gnome\.FileRoller"
        "float true, match:class file-roller"  # WHY IS THERE TWOOOOOOOOOOOOOOOO
        "float true, match:class blueman-manager"
        "float true, match:class com\.github\.GradienceTeam\.Gradience"
        "float true, match:class feh"
        "float true, match:class imv"
        "float true, match:class system-config-printer"
        "float true, match:class org\.quickshell"


        # Float, resize and center - nmtui
        "float true, match:class foot, match:title nmtui"
        "size 60% 70%, match:class foot, match:title nmtui"
        "center 1, match:class foot, match:title nmtui"
        "float true, match:class org\.gnome\.Settings"
        "size 70% 80%, match:class org\.gnome\.Settings"
        "center 1, match:class org\.gnome\.Settings"
        "float true, match:class org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "size 60% 70%, match:class org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "center 1, match:class org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "float true, match:class nwg-look"
        "size 50% 60%, match:class nwg-look"
        "center 1, match:class nwg-look"

        # Special workspaces
        "workspace special:sysmon, match:class btop"
        "workspace special:music, match:class feishin|Spotify|Supersonic|Cider"
        "workspace special:music, match:initial_title Spotify( Free)?  # Spotify wayland, it has no class for some reason"
        "workspace special:communication, match:class discord|equibop|vesktop|whatsapp"
        "workspace special:todo, match:class Todoist"

        # Dialogs
        "float true, match:title (Select|Open)( a)? (File|Folder)(s)?"
        "float true, match:title File (Operation|Upload)( Progress)?"
        "float true, match:title .* Properties"
        "float true, match:title Export Image as PNG"
        "float true, match:title GIMP Crash Debug"
        "float true, match:title Save As"
        "float true, match:title Library"

        # Picture in picture
        "move 100%-w-2% 100%-w-3%, match:title Picture(-| )in(-| )[Pp]icture"  # Initial move so window doesn't shoot across the screen from the center
        "keep_aspect_ratio true, match:title Picture(-| )in(-| )[Pp]icture"
        "float true, match:title Picture(-| )in(-| )[Pp]icture"
        "pin true, match:title Picture(-| )in(-| )[Pp]icture"

        # Steam
        "rounding 10, match:class steam"
        "float true, match:title Friends List, match:class steam"
        "immediate true, match:class steam_app_[0-9]+"  # Allow tearing for steam games
        "idle_inhibit always, match:class steam_app_[0-9]+"  # Always idle inhibit when playing a steam game

        # ATLauncher console
        "float true, match:class com-atlauncher-App, match:title ATLauncher Console"

        # Autodesk Fusion 360
        "no_blur true, match:title Fusion360|(Marking Menu), match:class fusion360\.exe"

        # Xwayland popups
        "no_dim true, match:xwayland 1, match:title win[0-9]+"
        "no_shadow true, match:xwayland 1, match:title win[0-9]+"
        "rounding 10, match:xwayland 1, match:title win[0-9]+"
      ];

      # Workspace rules
      workspace = [
        "w[tv1]s[false], gapsout:$singleWindowGapsOut"
        "f[1]s[false], gapsout:$singleWindowGapsOut"
      ];

      # Layer rules
      layerrule = [
        # Animations
        "animation fade, match:namespace hyprpicker"  # Colour picker out animation
        "animation fade, match:namespace logout_dialog"  # wlogout
        "animation fade, match:namespace selection"  # slurp
        "animation fade, match:namespace wayfreeze"

        # Fuzzel launcher
        "animation popin 80%, match:namespace launcher"
        "blur true, match:namespace launcher"

        # Caelestia shell
        "no_anim true, match:namespace caelestia-(border-exclusion|area-picker)"
        "animation fade, match:namespace caelestia-(drawers|background)"

        "blur true, match:namespace caelestia-drawers"
        "ignore_alpha 0.57, match:namespace caelestia-drawers"
      ];
    };
  };
}
