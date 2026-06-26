{ self, inputs, ... }: {
  flake.nixosConfigurations.hostTsukuyomi = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostTsukuyomiConfiguration
    ];
    specialArgs = { 
      inherit inputs; 
      username = "nozuchi";
    };
  };
}
