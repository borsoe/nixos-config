{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.systemSettings.thunar; # TODO, add support for other file managers
in
{

  options = {
    systemSettings.thunar = {
      enable = lib.mkEnableOption "Enable Thunar";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      ffmpegthumbnailer # Need For Video / Image Preview
    ];
  };
}
