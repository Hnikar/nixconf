{ self, inputs, ... }:
{
  flake.nixosConfigurations.hostTsukuyomi = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostTsukuyomiConfiguration
    ];
    specialArgs = {
      inherit inputs;
      username = "nozuchi";
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

  };
}
