{
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = ["alpha"];
        keepEnv = true;
        persist = true;
      }
    ];
  };
}