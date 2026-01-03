{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.systemSettings.niri;
in
{
  options = {
    systemSettings.niri = {
      enable = lib.mkEnableOption "Enable niri";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;
    environment.variables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite-unstable
    ];
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
  };
}
