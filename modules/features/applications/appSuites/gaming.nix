{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.steam
      ];
      packages = with pkgs; [
        lutris
        protonup-qt
      ];

      nixpkgs.overlays = [
        (final: prev: {
          openldap = prev.openldap.overrideAttrs (_: {
            doCheck = false;
          });
        })
      ];

    };
}
