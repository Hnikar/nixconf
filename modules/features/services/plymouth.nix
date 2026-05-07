{ self, inputs, ... }: {
  flake.nixosModules.plymouth = { pkgs, ...}: {
    nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ];
    boot = {
    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_sstatus=auto"
    ];
    };
  };
}