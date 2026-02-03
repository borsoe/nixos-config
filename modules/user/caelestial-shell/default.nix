{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.caelestial;
in
{
  options = {
    userSettings.caelestial = {
      enable = lib.mkEnableOption "Enable caelestial";
    };
  };

  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [
    #   # quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    #   inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
    # ];
    programs.caelestia = {
      enable = true;
      systemd = {
        enable = false; # if you prefer starting from your compositor
        target = "graphical-session.target";
        environment = [ ];
      };

      settings = {
        appearance.transparency.enable = true;
        background.visualiser = {
          blur = true;
          enable = true;
        };
        bar.status = {
          showBattery = false;
        };
        general.apps.terminal = "kitty";
        paths.wallpaperDir = "~/Images";
        services = {
          weatherLocation = "Tehran";
          useFahrenheit = false;
        }
      };

      cli = {
        enable = true; # Also add caelestia-cli to path
        settings = {
          theme.enableGtk = false;
        };
      };
    };
  };
}
