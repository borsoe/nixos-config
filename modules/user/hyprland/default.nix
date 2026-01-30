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
    userSettings.alacritty.enable = true;
    programs.alacritty.settings.window.opacity = lib.mkOverride 40 (if performance then 1.0 else 0.80);
    userSettings.kitty.enable = true;
    programs.kitty.settings.background_opacity = lib.mkOverride 40 (
      if performance then "1.0" else "0.80"
    );
    userSettings.emacs.opacity = lib.mkOverride 40 (if performance then 100 else 80);
    userSettings.dmenuScripts = {
      enable = true;
      dmenuCmd = "fuzzel -d";
    };
    userSettings.hyprland.hyprprofiles.enable = lib.mkDefault true;
    userSettings.stylix.enable = true;

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      #QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1.25";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      CLUTTER_BACKEND = "wayland";
      #GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
      #GSK_RENDERER = "gl";
      XCURSOR_THEME = config.gtk.cursorTheme.name;
      GDK_DEBUG = "portals";
      GTK_USE_PORTALS = 1;
      GRIM_DEFAULT_DIR = config.xdg.userDirs.extraConfig.XDG_SCREENSHOT_DIR;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-termfilechooser
      ];
    };

    xdg.portal.config.common = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };
    xdg.portal.config.hyprland = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };

    home.sessionVariables.TERMCMD = "kitty --class=filechoose_yazi";

    xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
    };

    gtk.cursorTheme = {
      package = pkgs.quintom-cursor-theme;
      name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
      size = 36;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
        inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
      ];
      settings = {
        env = [
          # "AQ_DRM_DEVICES,${config.home.sessionVariables.AQ_DRM_DEVICES}"
          "AW_NO_MODIFIERS,1"
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, wayland"
          "XDG_SESSION_DESKTOP, Hyprland"
          "QT_QPA_PLATFORMTHEME, qt6ct"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
          "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
          "GDK_BACKEND, wayland,x11"
          "QT_QPA_PLATFORM, wayland;xcb"
          "SDL_VIDEODRIVER, wayland,x11,windows"
          "CLUTTER_BACKEND, wayland"
          "ELECTRON_OZONE_PLATFORM_HINT, auto"
        ];
        exec-once = [
          # "WGPU_BACKEND=gl ashell"
          "hyprprofile Default"
          "ydotoold"
          "GOMAXPROCS=1 syncthing --no-browser"
          "blueman-applet"
          "gnome-keyring-daemon --start --components=secrets"
          "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "trash-empty 30"
          "mpris-proxy"
          "caelestia resizer -d"
          "caelestia shell -d"
          "hyprctl dispatch submap global"
        ];

        general = {
          layout = "scrolling";
          border_size = 2;
          "col.active_border" =
            if performance then
              "0xff${config.lib.stylix.colors.base0B}"
            else
              "0xff${config.lib.stylix.colors.base08} 0xff${config.lib.stylix.colors.base09} 0xff${config.lib.stylix.colors.base0A} 0xff${config.lib.stylix.colors.base0B} 0xff${config.lib.stylix.colors.base0C} 0xff${config.lib.stylix.colors.base0D} 0xff${config.lib.stylix.colors.base0E} 0xff${config.lib.stylix.colors.base0F} 270deg";
          "col.inactive_border" = "0xff${config.lib.stylix.colors.base02}";
          resize_on_border = true;
          gaps_in = 14;
          gaps_out = 14;
        };

        plugin = {
          hyprtasking = {
            layout = "linear";
            bg_color = "0xff${config.lib.stylix.colors.base02}";
          };
        };

        group = {
          "col.border_active" = config.wayland.windowManager.hyprland.settings.general."col.active_border";
          "col.border_inactive" =
            config.wayland.windowManager.hyprland.settings.general."col.inactive_border";
          groupbar = {
            gradients = false;
            "col.active" = "0xff${config.lib.stylix.colors.base0B}";
            "col.inactive" = "0xff${config.lib.stylix.colors.base02}";
          };
        };

        decoration = {
          shadow = {
            enabled = (!performance);
          };
          rounding = 12;
          dim_special = 0.0;
          dim_inactive = true;
          dim_strength = 0.15;
          blur = {
            enabled = (!performance);
            size = 10;
            passes = 3;
            ignore_opacity = true;
            contrast = 1.17;
            brightness = (if (config.stylix.polarity == "dark") then "0.65" else "1.45");
            xray = (!performance);
            special = (!performance);
            popups = (!performance);
          };
        };

        cursor = {
          no_hardware_cursors = 1;
          no_warps = false;
          inactive_timeout = 30;
        };

        misc = {
          vfr = true;
          vrr = 1;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          disable_hyprland_logo = true;
          mouse_move_enables_dpms = true;
          force_default_wallpaper = 0;
          enable_swallow = true;
          swallow_regex = "(scratch_term)|(Alacritty)|(kitty)";
          font_family = font;
          focus_on_activate = true;
        };

        bezier = lib.optionals (!performance) [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.0"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "linear, 0.0, 0.0, 1.0, 1.0"
        ];

        animations = {
          enabled = (!performance);
          animation = lib.optionals (!performance) [
            "windowsIn, 1, 6, winIn, popin"
            "windowsOut, 1, 5, winOut, popin"
            "windowsMove, 1, 5, wind, slide"
            "border, 1, 10, default"
            "borderangle, 1, 100, linear, loop"
            "fade, 1, 10, default"
            "workspaces, 1, 5, wind"
            "windows, 1, 6, wind, slide"
            "specialWorkspace, 1, 6, default, slidefadevert -50%"
          ];
        };

        input = {
          kb_layout = "us ir";
          kb_options = "grp:win_space_toggle";
          repeat_delay = 450;
          repeat_rate = 50;
          accel_profile = "adaptive";
          follow_mouse = 2;
          float_switch_override_focus = 0;
        };

        binds = {
          movefocus_cycles_fullscreen = false;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

      };
      systemd.variables = [ "--all" ];
      xwayland = {
        enable = true;
      };
      systemd.enable = false;
    };

    home.packages = (
      with pkgs;
      [
        qpwgraph
        networkmanagerapplet
        hyprland-monitor-attached
        alacritty
        kitty
        killall
        polkit_gnome
        # (ashell.overrideAttrs (o: {
        #   patches = (o.patches or [ ]) ++ [
        #     ./ashell.patch
        #   ];
        # }))
        libva-utils
        libinput-gestures
        gsettings-desktop-schemas
        hyprnome
        wlr-randr
        wtype
        ydotool
        wl-clipboard
        hyprland-protocols
        hyprpicker
        # inputs.hyprlock.packages.${pkgs.system}.default
        # hypridle
        keepmenu
        pinentry-gnome3
        wev
        grim
        slurp
        kdePackages.qtwayland
        xdg-utils
        wlsunset
        hyprshade
        pavucontrol
      ]
    );
    home.file.".config/hypr/shaders/grayscale.glsl".text = ''
      /*
       * Grayscale
       */
      #version 300 es

      precision highp float;
      in vec2 v_texcoord;
      uniform sampler2D tex;
      out vec4 fragColor;

      // Enum for type of grayscale conversion
      const int LUMINOSITY = 0;
      const int LIGHTNESS = 1;
      const int AVERAGE = 2;

      /**
       * Type of grayscale conversion.
       */
      const int Type = LUMINOSITY;

      // Enum for selecting luma coefficients
      const int PAL = 0;
      const int HDTV = 1;
      const int HDR = 2;

      /**
       * Formula used to calculate relative luminance.
       * (Only applies to type = "luminosity".)
       */
      const int LuminosityType = HDR;

      void main() {
          vec4 pixColor = texture2D(tex, v_texcoord);

          float gray;
          if (Type == LUMINOSITY) {
              // https://en.wikipedia.org/wiki/Grayscale#Luma_coding_in_video_systems
              if (LuminosityType == PAL) {
                  gray = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));
              } else if (LuminosityType == HDTV) {
                  gray = dot(pixColor.rgb, vec3(0.2126, 0.7152, 0.0722));
              } else if (LuminosityType == HDR) {
                  gray = dot(pixColor.rgb, vec3(0.2627, 0.6780, 0.0593));
              }
          } else if (Type == LIGHTNESS) {
              float maxPixColor = max(pixColor.r, max(pixColor.g, pixColor.b));
              float minPixColor = min(pixColor.r, min(pixColor.g, pixColor.b));
              gray = (maxPixColor + minPixColor) / 2.0;
          } else if (Type == AVERAGE) {
              gray = (pixColor.r + pixColor.g + pixColor.b) / 3.0;
          }
          vec3 grayscale = vec3(gray);

          fragColor = vec4(grayscale, pixColor.a);
      }
    '';
    # home.file.".config/ashell/config.toml".text = ''
    #   outputs = "All"
    #   position = "Top"
    #   app_launcher_cmd = "nwggrid-wrapper"
    #   truncate_title_after_length = 150
    #   [modules]
    #   left = [ "AppLauncher", "SystemInfo" ]
    #   center = [ "Workspaces" ]
    #   right = [ "Clock", "Settings", "Tray" ]
    #   [workspaces]
    #   visibility_mode = "MonitorSpecific"
    #   enable_workspace_filling = true
    #   [system.cpu]
    #   warn_threshold = 80
    #   alert_threshold = 95
    #   [system.mem]
    #   warn_threshold = 50
    #   alert_threshold = 75
    #   [system.temp]
    #   warn_threshold = 85
    #   alert_threshold = 95
    #   [clock]
    #   format = "%a %d %b %H:%M:%S"
    #   [mediaPlayer]
    #   max_title_length = 100
    #   [settings]
    #   lockCmd = "hyprlock &"
    #   audio_sinks_more_cmd = "pavucontrol -t 3"
    #   audio_sources_more_cmd = "pavucontrol -t 4"
    #   wifi_more_cmd = "nm-connection-editor"
    #   vpn_more_cmd = "nm-connection-editor"
    #   bluetooth_more_cmd = "blueman-manager"
    #   [appearance]
    #   scale_factor = 1.25
    #   style = "Solid"
    #   opacity = ${if performance then "1.0" else "0.7"}
    #   background_color = "#${config.lib.stylix.colors.base00}88"
    #   primary_color = "#${config.lib.stylix.colors.base0A}"
    #   secondary_color = "#${config.lib.stylix.colors.base01}"
    #   success_color = "#${config.lib.stylix.colors.base0A}"
    #   danger_color = "#${config.lib.stylix.colors.base08}"
    #   text_color = "#${config.lib.stylix.colors.base07}"
    #   workspace_colors = [ "#${config.lib.stylix.colors.base0B}", "#${config.lib.stylix.colors.base0B}" ]
    #   specialWorkspaceColors = [ "#${config.lib.stylix.colors.base0B}", "#${config.lib.stylix.colors.base0B}" ]
    #   [appearance.menu]
    #   opacity = ${if performance then "1.0" else "0.7"}
    #   backdrop = 0.0
    # '';
    services.hyprpolkitagent.enable = true;
    services.swayosd.enable = true;
    services.swayosd.topMargin = 0.5;

    services.udiskie.enable = true;
    services.udiskie.tray = "never";
    programs.fuzzel.enable = true;
    programs.fuzzel.package = pkgs.fuzzel;
    programs.fuzzel.settings = {
      main = {
        font = font + ":size=20";
        dpi-aware = "no";
        show-actions = "yes";
        terminal = "${pkgs.alacritty}/bin/alacritty";
      };
      colors = {
        background = config.lib.stylix.colors.base00 + (if performance then "ff" else "bf");
        text = config.lib.stylix.colors.base07 + "ff";
        match = config.lib.stylix.colors.base05 + "ff";
        selection = config.lib.stylix.colors.base08 + "ff";
        selection-text = config.lib.stylix.colors.base00 + "ff";
        selection-match = config.lib.stylix.colors.base05 + "ff";
        border = config.lib.stylix.colors.base08 + "ff";
      };
      border = {
        width = 0;
        radius = 0;
      };
    };
  };
}
