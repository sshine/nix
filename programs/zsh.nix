# Platform-agnostic zsh configuration (works on NixOS and nix-darwin)
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.atuin # ^R
    pkgs.eza # ls
    pkgs.git # prompt, aliases
    pkgs.zoxide # j, ji commands
    pkgs.zsh-syntax-highlighting
  ];

  # Works on both platforms
  environment.shellAliases = {
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
    gria = "git rebase -i --autosquash";
    grb = "git rebase -i --autosquash $(git merge-base HEAD master)";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    # Common options (both platforms)
    enable = true;
    enableCompletion = true;

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

      # Omit username, print hostname + '$' with red when root, otherwise green:
      # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
      prompt='[%(!.%F{red}.%F{green})%m%f:%F{blue}%~%f]$(git_branch_name) %(!.%F{red}#%f.$) '

      # See: https://zsh.sourceforge.io/Doc/Release/Options.html#Prompting
      setopt prompt_cr    # print carriage return before printing a prompt in line editor
      setopt prompt_sp    # attempt to preserve partial lines using ansi control chars
      setopt prompt_subst # perform {parameter, command, arithmetic} expansion in prompts

      export PROMPT_EOL_MARK="" # don't show end-of-line marker on partial lines
    '';

    interactiveShellInit = ''
      # Enable bash completion compatibility
      autoload -U bashcompinit && bashcompinit

      # Disable ^S and ^Q flow control
      unsetopt FLOW_CONTROL

      # Copy-paste
      bindkey '^U' kill-whole-line
      bindkey '^Y' yank

      # ^R
      eval "$(atuin init zsh --disable-up-arrow)"

      # j as jumpy cd alternative
      eval "$(zoxide init zsh --cmd j)"

      # Syntax highlighting (must be sourced last)
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
  };
}
