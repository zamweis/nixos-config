{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {};
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "5.7.1";
        sha256 = "0f2q17d028j2c816rns9hi2w38ln3mssdcgzm6kc948ih252jflr";
      }
      {
        name = "vscode-emacs-friendly";
        publisher = "lfs";
        version = "0.9.0";
        sha256 = "1j4cy77m1077wdl2vvpmzi98y3jkycvf8z84pscs3lkkk1mvcsv1";
      }
      {
        name = "vscode-kubernetes-tools";
        publisher = "ms-kubernetes-tools";
        version = "1.2.1";
        sha256 = "071p27xcq77vbpnmb83pjsnng7h97q4gai0k6qgwg3ygv086hpf4";
      }
      {
        name = "vscode-yaml";
        publisher = "redhat";
        version = "0.11.1";
        sha256 = "0pxmw150k1n9mnfxf6v2bqqdwpkaglg2zx6r928cyjzzplpyd53x";
      }
      {
        name = "markdown-all-in-one";
        publisher = "yzhang";
        version = "3.3.0";
        sha256 = "0jq6zvppg6pagrzqisx3h3ra2x92x72xli41jmd464wr5jwrg0ls";
      }
    ];
  };
}