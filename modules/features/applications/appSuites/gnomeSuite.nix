{ self, inputs, ... }:
{
  flake.nixosModules.gnomeSuite =
    { pkgs, pkgs-unstable, ... }:
    let
      unstable = pkgs-unstable.extend (
        final: prev: {
          nautilus = prev.nautilus.overrideAttrs (old: {
            buildInputs =
              old.buildInputs
              ++ (with prev.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
          });
        }
      );
    in
    {
      services.gnome.sushi.enable = true;

      environment.systemPackages = with pkgs; [
        unstable.nautilus
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
