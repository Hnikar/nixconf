{ self, inputs, ... }: {
  flake.nixosModules.steam = { pkgs, ...}: {
    nixpkgs.overlays = [ inputs.millennium.overlays.default ];
    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
    };
    hardware.steam-hardware.enable = true;
  };
}