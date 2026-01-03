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

    # Necessary packages
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite-unstable
      (sddm-astronaut.override {
        # themeConfig = {
          # TODO Update Theme Config
          # https://github.com/Keyitdev/sddm-astronaut-theme/blob/master/Themes/astronaut.conf
          # background = config.stylix.image;
          # ScreenWidth = 1920;
          # ScreenHeight = 1080;
          # blur = false;
        # };
      })
    ];

    # Display manager
    services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        (sddm-astronaut.override {
          embeddedTheme = "Japanese aesthetic";
        })
      ];
    };
  };
}
