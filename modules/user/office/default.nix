{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}:

let
  cfg = config.userSettings.office;
in
{
  options = {
    userSettings.office = {
      enable = lib.mkEnableOption "Enable my office programs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      adwaita-icon-theme
      openvpn
    ];
  };
}
