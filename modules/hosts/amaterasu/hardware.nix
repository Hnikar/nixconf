{ self, inputs, ... }: {

  flake.nixosModules.hostAmaterasuHardware = { config, lib, pkgs, modulesPath, ... }: {
   imports = [ ];

    boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/00eab902-c098-4361-b103-a50f3823479a";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/00eab902-c098-4361-b103-a50f3823479a";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/B891-F797";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };

}
