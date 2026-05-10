{
  programs.git = {
    enable = true;

    settings = {
      include.path = "~/.gituser";
      commit.gpgsign = true;
      user = {
        name = "davanok";
        email = "r9195253857@gmail.com";
      };
      init.defaultBranch = "main";
      color.ui = true;
      gpg.format = "ssh";
    };

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}