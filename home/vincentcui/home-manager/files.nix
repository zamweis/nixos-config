let
  relativeConfigHomePath = "/config/home/vincentcui";
in
{
  # Nitrogen settings
  home.file.".config/nitrogen".source = builtins.toPath "${relativeConfigHomePath}/nitrogen";
  # Nix commands
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
  # Fonts
  home.file.".local/share/fonts".source = builtins.toPath "${relativeConfigHomePath}/fonts";
  # Rofi theme
  home.file.".config/rofi".source = builtins.toPath "${relativeConfigHomePath}/rofi";
}