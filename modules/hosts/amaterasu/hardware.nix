{ self, inputs, ... }: {

  flake.nixosModules.hostAmaterasuHardware = { config, lib, pkgs, modulesPath, ... }: {

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b03fa557-35b2-4020-a2e9-83dd046d11cd";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b03fa557-35b2-4020-a2e9-83dd046d11cd";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6971-79F7";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/var/mnt/linssd" =
    { device = "/dev/disk/by-uuid/377310d0-b604-47d5-a126-e18350b27ca5";
      fsType = "btrfs";
      options = ["nosuid,nodev,nofail,x-gvfs-show"];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

}
