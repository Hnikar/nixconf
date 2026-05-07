{ self, inputs, ... }: 
{
  flake.nixosModules.limine = { pkgs, ... }: {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.systemd-boot.enable = false;
    boot.loader.limine = rec {
      enable = true;
      efiSupport = true;
     # device = "nodev";
    };
  };
}