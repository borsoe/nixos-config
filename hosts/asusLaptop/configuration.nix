{ ... }:

{
  config = {
    systemSettings = {
      # users
      users = [ "borsoe" ];
      adminUsers = [ "borsoe" ];

      # hardware
      cachy.enable = true;
      cachy.variant = "lts";
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
      hyprland.enable = true;
      niri.enable = false;

      # file manager
      thunar.enable = true;

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
        theme = "catppuccin-frappe";
      };
    };

    users.users.borsoe.description = "Mohammad Reza";
    home-manager.users.borsoe.userSettings = {
      name = "Mohammad Reza";
      email = "borsoe.reza@gmail.com";
    };

    # Configure network proxy if necessary
    networking.proxy.default = "http://192.168.100.8:8080/";
    networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    ## EXTRA CONFIG GOES HERE

  };

}
