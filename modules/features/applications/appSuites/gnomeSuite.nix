{ self, inputs, ... }:
{
  flake.nixosModules.gnomeSuite =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          nautilus = prev.nautilus.overrideAttrs (old: {
            buildInputs =
              old.buildInputs
              ++ (with prev.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
          });
        })
      ];

      services.gnome.sushi.enable = true;

      environment.systemPackages = with pkgs; [
        nautilus
        gnome-text-editor

        ffmpegthumbnailer

        showtime
        gnome-calculator
        loupe
        papers
        snapshot
        decibels
        gnome-boxes
        pika-backup
        baobab
        gnome-disk-utility

        ###

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
      ];
    };
}
