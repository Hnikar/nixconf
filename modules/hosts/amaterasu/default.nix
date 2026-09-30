{ self, inputs, ... }:
{
  flake.nixosConfigurations.hostAmaterasu = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostAmaterasuConfiguration
    ];
    specialArgs = {
      inherit inputs;
      username = "izanagi";
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
  };
}
