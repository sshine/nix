{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ vim-lastplace vim-nix ];
        opt = [];
      };
      customRC = ''
        set nocompatible
        syntax on
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set expandtab
        set noshiftround

        set mouse=
        if !has('nvim')
          set ttymouse=
        endif
      '';
    };
  };
}
