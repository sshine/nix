{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.atuin  # ^R
    pkgs.eza    # ls
    pkgs.git    # prompt, aliases
    pkgs.zoxide # j, ji commands
  ];

  users.defaultUserShell = pkgs.zsh;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    enableGlobalCompInit = true;

    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [ "main" "brackets" ];

    setOptions = [
      # Disable ^S and ^Z for less accidental freezing.
      "FLOW_CONTROL"
    ];

    shellAliases = {
      # files
      rm = "rm -iv";
      ls = "eza -lg";
      tree = "eza -lgT";

      # git
      gs = "git status";
      gd = "git diff";
      gdc = "git diff --cached";
      gca = "git commit --amend";
      gcv = "git commit --verbose";
      gap = "git add -p";
      gl = "git log --decorate=short --color | less -R";
      gpr = "git pull --rebase";
      gcp = "git cherry-pick";
    };

    promptInit = ''
      autoload -U promptinit
      promptinit
      prompt off

      function git_branch_name() {
        branch=$(git symbolic-ref HEAD --short 2>/dev/null)
        if [ ! -z "$branch" ]; then
          echo -n " [%F{red}$branch%f]"
        fi
      }

      # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
      prompt='[%(!.%F{red}.%F{green})%m%f:%F{blue}%~%f]$(git_branch_name) %(!.%F{red}#%f.$) '

      # See: https://zsh.sourceforge.io/Doc/Release/Options.html#Prompting
      setopt prompt_cr    # print carriage return before printing a prompt in line editor
      setopt prompt_sp    # attempt to preserve partial lines using ansi control chars
      setopt prompt_subst # perform {parameter, command, arithmetic} expansion in prompts

      export PROMPT_EOL_MARK="" # don't show end-of-line marker on partial lines
    '';

    interactiveShellInit = ''
      # ^R
      eval "$(atuin init zsh --disable-up-arrow)"

      # z
      eval "$(zoxide init zsh --cmd j)"
    '';
  };
}
