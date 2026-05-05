{ self, inputs, ... }: 
{
  flake.nixosModules.gnomeSuite = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nautilus
      gnome-text-editor
      showtime
      gnome-calculator
      loupe
      papers
      showtime
      snapshot
      decibels
      gnome-boxes
      pika-backup
      baobab
      gnome-disk-utility
    ];
  };
}