{ nixvim, ... }: {
  imports = [
    nixvim.nixosModules.default
  ];

  nixpkgs.overlays = [
    nixvim.overlays.default
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPlugins = [];

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
  };
}
