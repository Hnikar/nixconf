{ self, inputs, ... }: {
  flake.nixosModules.discord = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.discord
      ];
  };
}
