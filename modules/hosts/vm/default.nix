{ self, inputs, ... }: {
  flake.nixosConfigurations.hostAmaterasu = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostAmaterasuConfiguration
    ];
    specialArgs = { 
      inherit inputs; 
      username = "izanagi";
    };
  };
}
