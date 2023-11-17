{ pkgs }: {
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["alpha"];
  environment.systemPackages = [pkgs.docker-compose];
}
