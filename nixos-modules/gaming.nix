{ pkgs, config, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    steam-run
    gnomeExtensions.dash-to-dock
    albert
  ];

  # use proprietary nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  users.users.mat = { shell = pkgs.fish; };
  nixpkgs.config.firefox.enableGnomeExtensions = true;
}
