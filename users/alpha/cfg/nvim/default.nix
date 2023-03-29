{ pkgs }: {
  home.file = {
    ".config/nvim".source = pkgs.fetchFromGitHub {
      owner = "AlphaTechnolog";
      repo = "nvim";
      rev = "6f78d5071359a00430e8b42c7440d6c2f43f1ec5";
      sha256 = "/aYVr4aE6s+aAzCkCGqxhJLSPHbOalsXlACrJd2dO74=";
    };
  };
}
