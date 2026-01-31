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

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.plugin = {
      # hyprtasking = {
      #   layout = "grid";
      #   bg_color = "0xff${config.lib.stylix.colors.base02}";
      #   grid =  {
      #               cols = 1;
      #               loop = false;
      #               gaps_use_aspect_ratio = false;
      #           };
      # };
      hyprscrolling = {
         fullscreen_on_one_column = true;
      };
    };
  };
}
