{ self, inputs, ... }: 
{
  flake.nixosModules.grub = { pkgs, ... }: {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.systemd-boot.enable = false;
    boot.loader.grub = rec {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;

      theme = inputs.distro-grub-themes.packages.x86_64-linux.nixos-grub-theme;
      splashImage = "${theme}/splash_image.jpg";
    };
  };
}