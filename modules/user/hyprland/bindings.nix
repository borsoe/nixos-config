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
  options = {
    userSettings.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
      performanceOptimizations = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable performance optimizations";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings ={
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
      "$kbMoveWinToWs" = "Super+Alt";
      "$kbMoveWinToWsGroup" = "Ctrl+Super+Alt";
      "$kbGoToWs" = "Super";
      "$kbGoToWsGroup" = "Ctrl+Super";
      "$kbNextWs" = "Super, down";  # Changed to down for niri-like
      "$kbPrevWs" = "Super, up";    # Changed to up for niri-like
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
      "$kbWindowFullscreen" = "Super, F";
      "$kbWindowBorderedFullscreen" = "Super+Alt, F";
      "$kbToggleWindowFloating" = "Super+Alt, Space";
      "$kbCloseWindow" = "Super, Q";

      # Caelestia Variables - Keybinds for Special Workspaces
      "$kbSystemMonitor" = "Ctrl+Shift, Escape";
      "$kbMusic" = "Super, M";
      "$kbCommunication" = "Super, D";
      "$kbTodo" = "Super, R";

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

      # Submaps
      exec-once = "hyprctl dispatch submap global";

      # Caelestia Shell Launcher bindings
      bindi = [
        "Super, Super_L, global, caelestia:launcher"
      ];

      bindin = [
        "Super, catchall, global, caelestia:launcherInterrupt"
        "Super, mouse:272, global, caelestia:launcherInterrupt"
        "Super, mouse:273, global, caelestia:launcherInterrupt"
        "Super, mouse:274, global, caelestia:launcherInterrupt"
        "Super, mouse:275, global, caelestia:launcherInterrupt"
        "Super, mouse:276, global, caelestia:launcherInterrupt"
        "Super, mouse:277, global, caelestia:launcherInterrupt"
        "Super, mouse_up, global, caelestia:launcherInterrupt"
        "Super, mouse_down, global, caelestia:launcherInterrupt"
      ];

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
        "$kbTodo, exec, caelestia toggle todo"
        "$kbToggleSpecialWs, exec, caelestia toggle specialws"

        # Hyprtasking
        "SUPER, tab, hyprtasking:toggle, all"
        "SUPER+Alt, tab, hyprtasking:toggle, cursor"
        ", escape, hyprtasking:if_active, hyprtasking:toggle cursor"
        "SUPER, X, hyprtasking:killhovered"


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
        "Super, left, movefocus, l"
        "Super, right, movefocus, r"

        # Window actions - Move windows (LEFT/RIGHT for horizontal within workspace)
        "Super+Shift, left, movewindow, l"
        "Super+Shift, right, movewindow, r"

        # Window actions - Other
        "Ctrl+Super, Backslash, centerwindow, 1"
        "Ctrl+Super+Alt, Backslash, resizeactive, exact 55% 70%"
        "$kbWindowPip, exec, caelestia resizer pip"
        "$kbPinWindow, pin"
        "$kbWindowFullscreen, fullscreen, 0"
        "$kbWindowBorderedFullscreen, fullscreen, 1"
        "$kbToggleWindowFloating, togglefloating"
        "$kbCloseWindow, killactive"

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
        # Note: Using workspace e+1/e-1 for relative navigation
        "Super, down, workspace, e+1"
        "Super, up, workspace, e-1"

        # Alternative workspace navigation with mouse
        "Super, mouse_down, workspace, e+1"
        "Super, mouse_up, workspace, e-1"

        # Move window to workspace - UP/DOWN (niri-like)
        "Super+Ctrl, down, movetoworkspace, e+1"
        "Super+Ctrl, up, movetoworkspace, e-1"

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
      ];

      # Repeated bindings (hold to repeat)
      binde = [
        # Window resizing
        "Super, Minus, splitratio, -0.1"
        "Super, Equal, splitratio, 0.1"

        # Workspace navigation (repeated for smooth scrolling)
        "$kbPrevWs, workspace, e-1"
        "$kbNextWs, workspace, e+1"

        # Move window to workspace (repeated)
        "Super+Alt, up, movetoworkspace, e-1"
        "Super+Alt, down, movetoworkspace, e+1"

        # Window group cycling
        "$kbWindowGroupCycleNext, cyclenext"
        "$kbWindowGroupCyclePrev, cyclenext, prev"
        "Ctrl+Alt, Tab, changegroupactive, f"
        "Ctrl+Shift+Alt, Tab, changegroupactive, b"
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
    };

      # bind = [
      #   "SUPER, Q, exec, kitty"
      #   "SUPER, C, killactive"
      #   "SUPER, M, exit"
      #   "SUPER,SPACE,fullscreen,1"
      #   "SUPERSHIFT,F,fullscreen,0"
      #   "SUPER,Y,workspaceopt,allfloat"
      #   "ALT,TAB,cyclenext"
      #   "ALT,TAB,bringactivetotop"
      #   "ALTSHIFT,TAB,cyclenext,prev"
      #   "ALTSHIFT,TAB,bringactivetotop"
      #   "SUPER,W,togglegroup"
      #   "SUPER,TAB,changegroupactive,f"
      #   "SUPERSHIFT,TAB,changegroupactive,b"
      #   ''SUPER,V,exec,wl-copy $(wl-paste | tr "\n" " ")''
      #   "SUPERSHIFT,T,exec,screenshot-ocr"
      #   "CTRLALT,Delete,exec,hyprctl kill"
      #   "SUPERSHIFT,K,exec,hyprctl kill"
      #   "SUPER,R,pass,^(com\.obsproject\.Studio)$"
      #   "SUPERSHIFT,R,pass,^(com\.obsproject\.Studio)$"
      #   "SUPER,RETURN,exec,${term}"
      #   "SUPERSHIFT,RETURN,exec,${term} --class float_term"
      #   "SUPER,A,exec,${spawnEditor}"
      #   "SUPERCTRL,S,exec,container-open"
      #   "SUPERCTRL,P,pin"
      #   "SUPER,code:47,exec,fuzzel"

      #   "SUPERSHIFT,Q,exit"
      #   "SUPER,T,togglefloating"
      #   ",code:148,exec,${term} -e numbat"
      #   '',code:107,exec,grim -g "$(slurp)"''
      #   ''SHIFT,code:107,exec,grim -g "$(slurp -o)"''
      #   "SUPER,code:107,exec,grim"
      #   ''CTRL,code:107,exec,grim -g "$(slurp)" - | wl-copy''
      #   ''SHIFTCTRL,code:107,exec,grim -g "$(slurp -o)" - | wl-copy''
      #   "SUPERCTRL,code:107,exec,grim - | wl-copy"
      #   "SUPER,C,exec,wl-copy $(hyprpicker)"
      #   "SUPERCTRL,G,exec,hyprgamemode"
      #   "SUPER,H,movefocus,l"
      #   "SUPER,J,movefocus,d"
      #   "SUPER,K,movefocus,u"
      #   "SUPER,L,movefocus,r"
      #   "SUPERSHIFT,H,movewindow,l"
      #   "SUPERSHIFT,J,movewindow,d"
      #   "SUPERSHIFT,K,movewindow,u"
      #   "SUPERSHIFT,L,movewindow,r"
      #   "SUPER,1,focusworkspaceoncurrentmonitor,1"
      #   "SUPER,2,focusworkspaceoncurrentmonitor,2"
      #   "SUPER,3,focusworkspaceoncurrentmonitor,3"
      #   "SUPER,4,focusworkspaceoncurrentmonitor,4"
      #   "SUPER,5,focusworkspaceoncurrentmonitor,5"
      #   "SUPER,6,focusworkspaceoncurrentmonitor,6"
      #   "SUPER,7,focusworkspaceoncurrentmonitor,7"
      #   "SUPER,8,focusworkspaceoncurrentmonitor,8"
      #   "SUPER,9,focusworkspaceoncurrentmonitor,9"
      #   "SUPERCTRL,right,exec,hyprnome"
      #   "SUPERCTRL,left,exec,hyprnome --previous"
      #   "SUPERSHIFT,right,exec,hyprnome --move"
      #   "SUPERSHIFT,left,exec,hyprnome --previous --move"
      #   "SUPERSHIFT,1,movetoworkspace,1"
      #   "SUPERSHIFT,2,movetoworkspace,2"
      #   "SUPERSHIFT,3,movetoworkspace,3"
      #   "SUPERSHIFT,4,movetoworkspace,4"
      #   "SUPERSHIFT,5,movetoworkspace,5"
      #   "SUPERSHIFT,6,movetoworkspace,6"
      #   "SUPERSHIFT,7,movetoworkspace,7"
      #   "SUPERSHIFT,8,movetoworkspace,8"
      #   "SUPERSHIFT,9,movetoworkspace,9"
      #   ''SUPER,Z,exec,if hyprctl clients | grep scratch_term; then echo "scratch_term respawn not needed"; else alacritty --class scratch_term; fi''
      #   "SUPER,Z,togglespecialworkspace,scratch_term"
      #   ''SUPER,F,exec,if hyprctl clients | grep scratch_yazi; then echo "scratch_yazi respawn not needed"; else kitty --class scratch_yazi -e yazi; fi''
      #   "SUPER,F,togglespecialworkspace,scratch_yazi"
      #   ''SUPER,N,exec,if hyprctl clients | grep scratch_numbat; then echo "scratch_numbat respawn not needed"; else alacritty --class scratch_numbat -e numbat; fi''
      #   "SUPER,N,togglespecialworkspace,scratch_numbat"
      #   ''SUPER,B,exec,if hyprctl clients | grep scratch_btm; then echo "scratch_yazi respawn not needed"; else alacritty --class scratch_btm -e btm; fi''
      #   "SUPER,B,togglespecialworkspace,scratch_btm"
      #   ''SUPER,D,exec,if hyprctl clients | grep Element; then echo "scratch_chat respawn not needed"; else element-desktop; fi''
      #   "SUPER,D,togglespecialworkspace,scratch_chat"
      #   ''SUPER,equal, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 + 0.5}')"''
      #   ''SUPER,minus, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 - 0.5}')"''
      #   "SUPER,I,exec,networkmanager_dmenu"
      #   "SUPER,P,exec,keepmenu"
      #   "SUPERSHIFT,P,exec,hyprprofile-dmenu"
      #   "SUPERCTRL,R,exec,phoenix refresh"
      #   "SUPER,S,exec,${spawnBrowser}"
      # ];

      # bindr = [
      #   "SUPER,SUPER_L,exec,nwggrid-wrapper"
      # ];

      # bindm = [
      #   "SUPER,mouse:272,movewindow"
      #   "SUPER,mouse:273,resizewindow"
      # ];

      # bindl = [
      #   ",switch:on:Lid Switch,exec,loginctl lock-session"
      #   "SUPERSHIFT,S,exec,systemctl suspend"
      #   "SUPERCTRL,L,exec,loginctl lock-session"
      #   ",code:122,exec,swayosd-client --output-volume lower"
      #   ",code:123,exec,swayosd-client --output-volume raise"
      #   ",code:121,exec,swayosd-client --output-volume mute-toggle"
      #   ",code:256,exec,swayosd-client --output-volume mute-toggle"
      #   "SHIFT,code:122,exec,swayosd-client --output-volume lower"
      #   "SHIFT,code:123,exec,swayosd-client --output-volume raise"
      #   ",code:232,exec,swayosd-client --brightness lower"
      #   ",code:233,exec,swayosd-client --brightness raise"
      #   ",code:237,exec,brightnessctl --device='asus::kbd_backlight' set 1-"
      #   ",code:238,exec,brightnessctl --device='asus::kbd_backlight' set +1"
      #   ",code:255,exec,airplane-mode"
      #   "SUPER,X,exec,fnottctl dismiss"
      #   "SUPERSHIFT,X,exec,fnottctl dismiss all"
      # ];
    }
  }
