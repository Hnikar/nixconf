{ self, inputs, ... }:
{

  flake.nixosModules.hostTsukuyomiHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {

      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/mapper/luks-b9e28258-91ec-41b1-b293-728b4780cf65";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

      boot.initrd.luks.devices."luks-b9e28258-91ec-41b1-b293-728b4780cf65".device =
        "/dev/disk/by-uuid/b9e28258-91ec-41b1-b293-728b4780cf65";

      fileSystems."/home" = {
        device = "/dev/mapper/luks-b9e28258-91ec-41b1-b293-728b4780cf65";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/B892-F5F4";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        {
          device = "/swapfile";
          size = 4096;
        }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
