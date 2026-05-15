{ self, inputs, ... }: 
{
  flake.nixosModules.containerTools = { pkgs, ... }: {
   environment.systemPackages = with pkgs; [
      distrobox
      distroshelf
      podman-desktop
   ];
    virtualisation = {
      containers.enable = true;
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
      podman = {
        enable = true;
        #dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };
  };
}