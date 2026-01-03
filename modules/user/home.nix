{ ... }:

{
  # This will make home-manager overwrite existing files for all xdg.configFile entries
  home.activation.checkLinkTargets = lib.mkForce "";
}
