{ config, pkgs, ...}:
{
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/c415bbb58422c967cf979780a962e4048da018b0/nixos-mailserver-c415bbb58422c967cf979780a962e4048da018b0.tar.gz";
      sha256 = "02k25bh4pg31cx40ri4ynjw65ahy0mmj794hi5i1yn48j56vdbkj";
    })
    (import ../default/configuration.nix {
      inherit config pkgs;
      useDHCP = false;
    })
  ];

  networking = {
    interfaces.ens18 = {
      ipv4.addresses = [
        {
          address = "10.0.0.103";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "10.0.0.2";
    hostName = "mail";
  };

  security.acme.acceptTerms = true;
  security.acme.email = "wenvincent.cui@gmail.com";

  mailserver = {
    enable = true;
    fqdn = "mail.vincentcui.de";
    domains = [
      "vincentcui.de"
      "gitlab.vincentcui.de"
    ];

    loginAccounts = {
      "privat@vincentcui.de" = {
        hashedPassword = "$6$ixhU/YllY.6/SaXG$JPkJhPY1kJOnDmWd1.dfnnMIr8d618.F.fHE5qBRUT7elT6YCigVN4dRCyLcPYFK9eHuDc1dHjTC/1ebr/pey0";

        aliases = [
          "postmaster@vincentcui.de"
          "studium@vincentcui.de"
        ];
      };
      "noreply@gitlab.vincentcui.de" = {
        hashedPassword = "$6$/vzQaRJfV$aLvKmdGgwjAklfUMeKCFc9Bh91t89LAly9AEGMWas0ktmvwH7/x6eeAnxn2ypjWMQfr/F0vb0zXRuOOtNjBnv.";

        aliases = [
          "gitlab@gitlab.vincentcui.de"
        ];
      };
    };

    certificateScheme = 3;

    enableImap = true;
    # enablePop3 = true;
    # enableImapSsl = true;
    # enablePop3Ssl = true;

    enableManageSieve = true;

    virusScanning = true;
  };
}
