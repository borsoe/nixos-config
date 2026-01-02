{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.userSettings.zen;
in
{
  options = {
    userSettings.zen = {
      enable = lib.mkEnableOption "Enable zen browser";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
