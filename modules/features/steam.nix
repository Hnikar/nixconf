{ self, inputs, ... }: {
  flake.nixosModules.steam = { pkgs, ...}: {
    programs.steam = {
      enable = true;
    };
    hardware.steam-hardware.enable = true;
  };
}

