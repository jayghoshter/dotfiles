{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jayghoshter";
  home.homeDirectory = "/home/jayghoshter";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # nixpkgs.overlays = [];

  home.packages = with pkgs; [ 
    nix-direnv
    cachix

    vscode-extensions.ms-vscode.cpptools

    neomutt
    # rr

    # glibc
    gmsh_with_libs
    comma
    ffsend

    nix-info

    # Global python packages for my scripts
    (python311.withPackages(ps: with ps; [ 
      ipython 
      numpy
      scipy
      plumbum
      pyfzf
      joblib
      beautifulsoup4
      requests
      pulsectl
      lz4
      i3ipc
      i3-py
      rich
      xdg
      deepdiff
      ruamel_yaml
      markdownify
      argcomplete
      magic
      pdfrw
      spotipy
      python-gnupg
      gpgme
      wget
      pygithub
      papis-python-rofi
    ]))

  ];

  programs.bat.enable = true;

}
