{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Toronto";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.getty.autologinUser = "zm";

  services.tuned.enable = true;

  services.upower.enable = true;

  users.users.zm = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    git-credential-manager
    kitty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.NF-CN
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
