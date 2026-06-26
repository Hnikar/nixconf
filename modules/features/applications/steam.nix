{ self, inputs, ... }:
{
  flake.nixosModules.steam =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.millennium.overlays.default ];
      programs.steam = {
        enable = true;
        # gamescopeSession.enable = true;
        package = pkgs.millennium-steam;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
      hardware.steam-hardware.enable = true;
    };
}
