{ self, inputs, ... }:
{
  flake.nixosModules.dev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        pnpm
      ];
    };
}
