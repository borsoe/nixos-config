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
      windowrulev2 = [
        # Opacity
        "opacity ${toString cfg.windowOpacity} override, fullscreen:0"

        # Opaque windows (native transparency or forced opaque)
        "opaque, class:^(foot|equibop|org\.quickshell|imv|swappy)$"

        # Center floating windows (not xwayland because of popups)
        "center, floating:1, xwayland:0"

        # Float rules
        "float, class:^(guifetch)$"
        "float, class:^(yad)$"
        "float, class:^(zenity)$"
        "float, class:^(wev)$"
        "float, class:^(org\.gnome\.FileRoller)$"
        "float, class:^(file-roller)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(com\.github\.GradienceTeam\.Gradience)$"
        "float, class:^(feh)$"
        "float, class:^(imv)$"
        "float, class:^(system-config-printer)$"
        "float, class:^(org\.quickshell)$"

        # Float, resize and center - nmtui
        "float, class:^(foot)$, title:^(nmtui)$"
        "size 60% 70%, class:^(foot)$, title:^(nmtui)$"
        "center 1, class:^(foot)$, title:^(nmtui)$"

        # Float, resize and center - GNOME Settings
        "float, class:^(org\.gnome\.Settings)$"
        "size 70% 80%, class:^(org\.gnome\.Settings)$"
        "center 1, class:^(org\.gnome\.Settings)$"

        # Float, resize and center - pavucontrol
        "float, class:^(org\.pulseaudio\.pavucontrol|yad-icon-browser)$"
        "size 60% 70%, class:^(org\.pulseaudio\.pavucontrol|yad-icon-browser)$"
        "center 1, class:^(org\.pulseaudio\.pavucontrol|yad-icon-browser)$"

        # Float, resize and center - nwg-look
        "float, class:^(nwg-look)$"
        "size 50% 60%, class:^(nwg-look)$"
        "center 1, class:^(nwg-look)$"

        # Special workspaces
        "workspace special:sysmon, class:^(btop)$"
        "workspace special:music, class:^(feishin|Spotify|Supersonic|Cider)$"
        "workspace special:music, initialTitle:^Spotify( Free)?$"
        "workspace special:communication, class:^(discord|equibop|vesktop|whatsapp)$"
        "workspace special:todo, class:^(Todoist)$"

        # Dialogs
        "float, title:^(Select|Open)( a)? (File|Folder)(s)?$"
        "float, title:^File (Operation|Upload)( Progress)?$"
        "float, title:^.* Properties$"
        "float, title:^Export Image as PNG$"
        "float, title:^GIMP Crash Debug$"
        "float, title:^Save As$"
        "float, title:^Library$"

        # Picture in picture
        "move 100%-w-2% 100%-w-3%, title:^Picture(-| )in(-| )[Pp]icture$"
        "keepaspectratio, title:^Picture(-| )in(-| )[Pp]icture$"
        "float, title:^Picture(-| )in(-| )[Pp]icture$"
        "pin, title:^Picture(-| )in(-| )[Pp]icture$"

        # Steam
        "rounding 10, class:^(steam)$"
        "float, title:^Friends List$, class:^(steam)$"
        "immediate, class:^steam_app_[0-9]+$"
        "idleinhibit always, class:^steam_app_[0-9]+$"

        # ATLauncher console
        "float, class:^(com-atlauncher-App)$, title:^ATLauncher Console$"

        # Autodesk Fusion 360
        "noblur, title:^Fusion360|(Marking Menu)$, class:^(fusion360\.exe)$"

        # Xwayland popups
        "nodim, xwayland:1, title:^win[0-9]+$"
        "noshadow, xwayland:1, title:^win[0-9]+$"
        "rounding 10, xwayland:1, title:^win[0-9]+$"
      ];

      # Workspace rules
      workspace = [
        "w[tv1]s[false], gapsout:20" # Single window gaps
        "f[1]s[false], gapsout:20"
      ];

      # Layer rules
      layerrule = [
        # Animations
        "animation fade, hyprpicker"
        "animation fade, logout_dialog"
        "animation fade, selection"
        "animation fade, wayfreeze"

        # Fuzzel launcher
        "animation popin 80%, launcher"
        "blur, launcher"

        # Caelestia shell
        "noanim, caelestia-(border-exclusion|area-picker)"
        "animation fade, caelestia-(drawers|background)"
        "blur, caelestia-drawers"
        "ignorealpha 0.57, caelestia-drawers"
      ];
    };
  };
}
