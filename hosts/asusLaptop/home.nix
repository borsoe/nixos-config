{ ... }:

{
  config = {
    userSettings = {
      # setup
      shell = {
        enable = true;
        apps.enable = true;
        extraApps.enable = true;
      };
      xdg.enable = true;

      # terminal
      terminal = "kitty";

      # programs
      browser = "zen";
      editor = "zed";
      vscodium.enable = false;
      yazi.enable = true;
      git.enable = true;
      engineering.enable = false;
      art.enable = false;
      flatpak.enable = false;
      godot.enable = false;
      keepass.enable = false;
      media.enable = true;
      music.enable = false;
      office.enable = true;
      recording.enable = false;
      virtualization = {
        virtualMachines.enable = false;
      };
      ai.enable = false;

      # wm
      hyprland.enable = false;
      niri.enable = true;
      niri.configVariant = "default";
      caelestial.enable = true;

      # style
      stylix.enable = true;

      # hardware
      bluetooth.enable = true;
    };

    ## EXTRA CONFIG GOES HERE

  };
}
