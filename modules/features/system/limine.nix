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
     extraEntries = ''
        /Windows
          protocol: efi
          path: uuid(DACB-4082):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
      extraConfig = ''
        term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
        term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
        term_background: 1e1e2e
        term_foreground: cdd6f4
        term_background_bright: 585b70
        term_foreground_bright: cdd6f4
        '';
    };
  };
}