{ ... }:

{
  config = {
    systemSettings = {
      # users
      users = [ "borsoe" ];
      adminUsers = [ "borsoe" ];

      # hardware
      cachy.enable = true;
      bluetooth.enable = true;
      tlp.enable = true;
      printing.enable = false;

      # software
      flatpak.enable = true;
      gaming.enable = true;
      virtualization = {
        docker.enable = true;
        virtualMachines.enable = false;
      };
      brave.enable = false;

      # wm
      hyprland.enable = false;
      niri.enable = true;

      # security
      security = {
        automount.enable = true;
        blocklist.enable = true;
        doas.enable = true;
        firejail.enable = false; # TODO setup firejail profiles
        firewall.enable = true;
        gpg.enable = true;
        openvpn.enable = true;
        sshd.enable = false;
      };

      # style
      stylix = {
        enable = true;
        theme = "orichalcum";
      };
    };

    users.users.borsoe.description = "Mohammad Reza";
    home-manager.users.borsoe.userSettings = {
      name = "Mohammad Reza";
      email = "borsoe.reza@gmail.com";
    };

    ## EXTRA CONFIG GOES HERE

  };

}
