{ self, inputs, ... }: {
  flake.nixosModules.discord = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        vesktop
      ];
  };
}
