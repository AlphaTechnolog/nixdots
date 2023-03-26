{ pkgs }: {
  home.file = {
    ".config/nvim".source = pkgs.fetchFromGitHub {
      owner = "AlphaTechnolog";
      repo = "nvim";
      rev = "0b3219f1925540977496e197ef7c812067c9d009";
      sha256 = "MpVAJYoAVS1DYGXd79v0BSIoMTJ1qq7NZ91IJO20qfQ=";
    };
  };
}
