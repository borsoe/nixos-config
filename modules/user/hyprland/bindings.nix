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
      # Caelestia Variables - Apps
      "$terminal" = "${config.userSettings.terminal}";
      "$browser" = "${config.userSettings.browser}";
      "$editor" = "${config.userSettings.editor}";
      "$fileExplorer" = "thunar";

      # Caelestia Variables - Styling
      "$volumeStep" = "10";
      "$cursorTheme" = "sweet-cursors";
      "$cursorSize" = "24";

      # Caelestia Variables - Keybinds for Workspaces
      "$kbToggleSpecialWs" = "Super, S";

      # Caelestia Variables - Keybinds for Window Groups
      "$kbWindowGroupCycleNext" = "Alt, Tab";
      "$kbWindowGroupCyclePrev" = "Shift+Alt, Tab";
      "$kbUngroup" = "Super, U";
      "$kbToggleGroup" = "Super, Comma";

      # Caelestia Variables - Keybinds for Window Actions
      "$kbMoveWindow" = "Super, Z";
      "$kbResizeWindow" = "Super, X";
      "$kbWindowPip" = "Super+Alt, Backslash";
      "$kbPinWindow" = "Super, P";
      "$kbWindowFullscreen" = "Super+Alt, F";
      "$kbWindowBorderedFullscreen" = "Super, F";
      "$kbToggleWindowFloating" = "Super+Alt, Space";
      "$kbCloseWindow" = "Super, Q";

      # Caelestia Variables - Keybinds for Special Workspaces
      "$kbSystemMonitor" = "Ctrl+Shift, Escape";
      "$kbMusic" = "Super, M";
      "$kbCommunication" = "Super, D";

      # Caelestia Variables - Keybinds for Apps
      "$kbTerminal" = "Super, T";
      "$kbBrowser" = "Super, W";
      "$kbEditor" = "Super, C";
      "$kbFileExplorer" = "Super, E";

      # Caelestia Variables - Keybinds for Misc
      "$kbSession" = "Ctrl+Alt, Delete";
      "$kbClearNotifs" = "Ctrl+Alt, C";
      "$kbShowPanels" = "Super, K";
      "$kbLock" = "Super, L";
      "$kbRestoreLock" = "Super+Alt, L";

      # Regular bindings
      bind = [
        # Caelestia Shell - Misc
        "$kbSession, global, caelestia:session"
        "$kbShowPanels, global, caelestia:showall"
        "$kbLock, global, caelestia:lock"

        # Caelestia - Special workspace toggles
        "$kbSystemMonitor, exec, caelestia toggle sysmon"
        "$kbMusic, exec, caelestia toggle music"
        "$kbCommunication, exec, caelestia toggle communication"
        # "$kbTodo, exec, caelestia toggle todo"
        "$kbToggleSpecialWs, exec, caelestia toggle specialws"

        # Hyprtasking
        # "SUPER, tab, hyprtasking:toggle, all"
        # "SUPER+Alt, tab, hyprtasking:toggle, cursor"
        # ", escape, hyprtasking:if_active, hyprtasking:toggle cursor"
        # "SUPER, X, hyprtasking:killhovered"

        # Apps
        "$kbTerminal, exec, $terminal"
        "$kbBrowser, exec, $browser"
        "$kbEditor, exec, $editor"
        "$kbFileExplorer, exec, $fileExplorer"
        # "Super, G, exec, github-desktop"
        # "Super+Alt, E, exec, nemo"
        "Ctrl+Alt, Escape, exec, qps"
        "Ctrl+Alt, V, exec, pavucontrol"

        # Window groups
        "$kbToggleGroup, togglegroup"
        "$kbUngroup, moveoutofgroup"
        "Super+Shift, Comma, lockactivegroup, toggle"

        # Window actions - Focus (LEFT/RIGHT for horizontal within workspace)
        # Commented out for hyprscroling
        # "Super, left, movefocus, l"
        # "Super, right, movefocus, r"

        # Window actions - Move windows (LEFT/RIGHT for horizontal within workspace)
        # Commented out for hyprscroling
        # "Super+Shift, left, movewindow, l"
        # "Super+Shift, right, movewindow, r"

        # Window actions - Other
        "Ctrl+Super, Backslash, centerwindow, 1"
        "Ctrl+Super+Alt, Backslash, resizeactive, exact 55% 70%"
        "$kbWindowPip, exec, caelestia resizer pip"
        "$kbPinWindow, pin"
        "$kbWindowFullscreen, fullscreen, 0"
        "$kbWindowBorderedFullscreen, fullscreen, 1"
        "$kbToggleWindowFloating, togglefloating"
        "$kbCloseWindow, killactive"

        # layoutmsgs for hyprscroling
        "Super, left, layoutmsg, move -col"
        "Super, right, layoutmsg, move +col"
        "Super+Shift, left, layoutmsg, swapcol l"
        "Super+Shift, right, layoutmsg, swapcol r"
        # "Super+Shift, down, layoutmsg, movewindowto d"
        # "Super+Shift, up, layoutmsg, movewindowto u"

        # Utilities - Screenshots
        "Super+Shift, S, global, caelestia:screenshotFreeze"
        "Super+Shift+Alt, S, global, caelestia:screenshot"
        "Super+Alt, R, exec, caelestia record -s"
        "Ctrl+Alt, R, exec, caelestia record"
        "Super+Shift+Alt, R, exec, caelestia record -r"
        "Super+Shift, C, exec, hyprpicker -a"

        # Clipboard and emoji
        "Super, V, exec, pkill fuzzel || caelestia clipboard"
        "Super+Alt, V, exec, pkill fuzzel || caelestia clipboard -d"
        "Super, Period, exec, pkill fuzzel || caelestia emoji -p"

        # Workspace navigation - UP/DOWN for vertical scrolling (niri-like)
        "Super, down, workspace, r+1"
        "Super, up, workspace, r-1"

        # Move window to workspace
        "Super+Alt, up, movetoworkspace, r-1"
        "Super+Alt, down, movetoworkspace, r+1"

        # Window group cycling
        "$kbWindowGroupCycleNext, cyclenext"
        "$kbWindowGroupCyclePrev, cyclenext, prev"
        "Ctrl+Alt, Tab, changegroupactive, f"
        "Ctrl+Shift+Alt, Tab, changegroupactive, b"

        # Alternative workspace navigation with mouse
        "Super, mouse_down, workspace, r+1"
        "Super, mouse_up, workspace, r-1"

        # Move window to workspace - UP/DOWN (niri-like)
        # Commented out for hyprscroling
        # "Super+Ctrl, down, movetoworkspace, e+1"
        # "Super+Ctrl, up, movetoworkspace, e-1"

        # Move window with follow
        "Super+Shift, down, movetoworkspace, e+1"
        "Super+Shift, up, movetoworkspace, e-1"

        # Special workspace
        "Ctrl+Super+Shift, up, movetoworkspace, special:special"
        "Ctrl+Super+Shift, down, movetoworkspace, e+0"
        "Super+Alt, S, movetoworkspace, special:special"

        # Named workspaces (keep for quick access)
        "Super, 1, workspace, 1"
        "Super, 2, workspace, 2"
        "Super, 3, workspace, 3"
        "Super, 4, workspace, 4"
        "Super, 5, workspace, 5"
        "Super, 6, workspace, 6"
        "Super, 7, workspace, 7"
        "Super, 8, workspace, 8"
        "Super, 9, workspace, 9"
        "Super, 0, workspace, 10"

        # Move to named workspace
        "Super+Alt, 1, movetoworkspace, 1"
        "Super+Alt, 2, movetoworkspace, 2"
        "Super+Alt, 3, movetoworkspace, 3"
        "Super+Alt, 4, movetoworkspace, 4"
        "Super+Alt, 5, movetoworkspace, 5"
        "Super+Alt, 6, movetoworkspace, 6"
        "Super+Alt, 7, movetoworkspace, 7"
        "Super+Alt, 8, movetoworkspace, 8"
        "Super+Alt, 9, movetoworkspace, 9"
        "Super+Alt, 0, movetoworkspace, 10"

        # Testing
        "Super+Alt, f12, exec, notify-send -u low -i dialog-information-symbolic 'Test notification' \"Here's a really long message to test truncation and wrapping\nYou can middle click or flick this notification to dismiss it!\" -a 'Shell' -A \"Test1=I got it!\" -A \"Test2=Another action\""

        # Sleep
        "Super+Shift, L, exec, systemctl suspend-then-hibernate"
      ];

      # Bindings with lock (work even when locked)
      bindl = [
        # Caelestia - Misc
        "$kbClearNotifs, global, caelestia:clearNotifs"
        "$kbRestoreLock, exec, caelestia shell -d"
        "$kbRestoreLock, global, caelestia:lock"

        # Brightness
        ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
        ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

        # Media
        "Ctrl+Super, Space, global, caelestia:mediaToggle"
        ", XF86AudioPlay, global, caelestia:mediaToggle"
        ", XF86AudioPause, global, caelestia:mediaToggle"
        "Ctrl+Super, Equal, global, caelestia:mediaNext"
        ", XF86AudioNext, global, caelestia:mediaNext"
        "Ctrl+Super, Minus, global, caelestia:mediaPrev"
        ", XF86AudioPrev, global, caelestia:mediaPrev"
        ", XF86AudioStop, global, caelestia:mediaStop"

        # Screenshots
        ", Print, exec, caelestia screenshot"

        # Volume
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "Super+Shift, M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Clipboard alternate paste
        "Ctrl+Shift+Alt, V, exec, sleep 0.5s && ydotool type -d 1 \"$(cliphist list | head -1 | cliphist decode)\""
      ];

      # Bindings with release (trigger on key release)
      bindr = [
        "Ctrl+Super+Shift, R, exec, qs -c caelestia kill"
        "Ctrl+Super+Alt, R, exec, qs -c caelestia kill; caelestia shell -d"
        "Super, R, global, caelestia:launcher" # Caelestia Shell Launcher bindings
      ];


      # Repeated bindings (hold to repeat)
      binde = [
        # Window resizing
        "Super, Minus, splitratio, -0.1"
        "Super, Equal, splitratio, 0.1"
      ];

      # Volume with repeat and lock
      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ $volumeStep%+"
        ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ $volumeStep%-"
      ];

      # Mouse bindings
      bindm = [
        "Super, mouse:272, movewindow"
        "$kbMoveWindow, movewindow"
        "Super, mouse:273, resizewindow"
        "$kbResizeWindow, resizewindow"
      ];

      bindin = [
        # "Super, catchall, global, caelestia:launcherInterrupt"
        "Super, mouse:272, global, caelestia:launcherInterrupt"
        "Super, mouse:273, global, caelestia:launcherInterrupt"
        "Super, mouse:274, global, caelestia:launcherInterrupt"
        "Super, mouse:275, global, caelestia:launcherInterrupt"
        "Super, mouse:276, global, caelestia:launcherInterrupt"
        "Super, mouse:277, global, caelestia:launcherInterrupt"
        "Super, mouse_up, global, caelestia:launcherInterrupt"
        "Super, mouse_down, global, caelestia:launcherInterrupt"
      ];
    };
  };
}
