{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
    matchBlocks."gitlab.vincentcui.de" = {
      hostname = "gitlab.vincentcui.de";
      user = "git";
      port = 9022;
    };
    matchBlocks."gitlab.campusjaeger.de" = {
      hostname = "gitlab.campusjaeger.de";
      user = "git";
      identityFile = "~/.ssh/id_rsa_cj";
    };
  };
}