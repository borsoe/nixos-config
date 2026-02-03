{ lib, config, pkgs, ... }:

let
  cfg = config.systemSettings.socials;
in {

  options = {
    systemSettings.gaming = {
      enable = lib.mkEnableOption "Enable telegram and discord";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;[
      telegram-desktop
      equibop
    ];
  };
}
