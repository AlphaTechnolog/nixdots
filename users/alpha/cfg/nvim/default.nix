{ pkgs }: {
  home.file = {
    ".config/nvim".source = pkgs.fetchFromGitHub {
      owner = "AlphaTechnolog";
      repo = "nvim";
      rev = "8acaed75455e264c9a2cb4b23afe478f311afe86";
      sha256 = "HDsq25wWosD+WvImxPA5AO2IjwCylCWS+lKl1eqy/3o=";
    };
  };
}
