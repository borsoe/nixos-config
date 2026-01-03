{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.niri;

  configFile =
      if cfg.configVariant == "default" then ./configs/default.kdl
      else if cfg.configVariant == "minimal" then ./configs/minimal.kdl
      else if cfg.configVariant == "gaming" then ./configs/gaming.kdl
      else if cfg.configVariant == "productivity" then ./configs/productivity.kdl
      else ./configs/default.kdl;

in
{
  options = {
    userSettings.niri = {
      enable = lib.mkEnableOption "Enable niri user configuration";
      configVariant = lib.mkOption {
        default = "default";
        type = lib.types.enum ["default" "minimal" "gaming" "productivity"]; # add new config options here
        description = "Niri configuration files";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Niri configuration file
    xdg.configFile."niri/config.kdl".source = configFile;
  };
}
