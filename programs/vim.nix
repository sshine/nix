{ pkgs, lib, nixvim, ... }: {
  imports = [
    nixvim.nixosModules.default
  ];

  nixpkgs.overlays = [
    nixvim.overlays.default
  ];

  environment.systemPackages = [
    pkgs.nixpkgs-fmt
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    # Use space as the <leader> keybinding
    globals.mapleader = " ";

    opts = {
      # Check for vim modeline at the top 3 lines
      modelines = 3;

      # Don't use line numbering (makes copy-paste hard)
      number = false;

      # Use spaces instead of tabs
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      shiftround = true;

      # Indent each line according to the previous
      cindent = false;
      smartindent = false;
      autoindent = true;

      # Disable terminal mouse support
      mouse = "";

      # Keep some lines above/below cursor line when scrolling
      scrolloff = 3;

      # Search is case-insensitive when using lowercase only
      ignorecase = true;
      smartcase = true;

      # Highlight search results
      showmatch = true;
    };

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
      };
    };
    plugins.web-devicons.enable = true;
    plugins.lualine.enable = true;
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          nix = [ "nixpkgs-fmt" ];
        };

        formatters = {
          "nixpkgs-fmt".command = lib.getExe pkgs.nixpkgs-fmt;
        };
      };
    };
  };
}
