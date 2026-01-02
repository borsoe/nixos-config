{
  input,
  pkgs,
  config,
  ...
}:

let
  cfg = config.systemSettings.caelestial;
in
{
  options ={
    systemSettings.caelestial = {
      enable = lib.mkEnableOption "Enable caelestial-shell";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.caelestia = {
      enable = true;
      systemd = {
        enable = false; # if you prefer starting from your compositor
        target = "graphical-session.target";
        environment = [];
      };
      settings = {
        bar.status = {
          showBattery = false;
        };
        paths.wallpaperDir = "~/Images";
      };
      cli = {
        enable = true; # Also add caelestia-cli to path
        settings = {
          theme.enableGtk = false;
        };
      };
    };
    ];
  };
};
