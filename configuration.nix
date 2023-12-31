# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/Sao_Paulo";
	time.hardwareClockInLocalTime = true;

# Select internationalisation properties.
	i18n.defaultLocale = "pt_BR.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_BR.UTF-8";
		LC_IDENTIFICATION = "pt_BR.UTF-8";
		LC_MEASUREMENT = "pt_BR.UTF-8";
		LC_MONETARY = "pt_BR.UTF-8";
		LC_NAME = "pt_BR.UTF-8";
		LC_NUMERIC = "pt_BR.UTF-8";
		LC_PAPER = "pt_BR.UTF-8";
		LC_TELEPHONE = "pt_BR.UTF-8";
		LC_TIME = "pt_BR.UTF-8";
	};

# Configure keymap in X11
	services.xserver = {
		layout = "br";
		xkbVariant = "";
		enable = true;
		windowManager.qtile = {
			enable = true;
			extraPackages = p: with p;
			[qtile-extras];
		};
		videoDrivers=["nvidia"];
#displayManager.lightdm.enblae=true;
	};

# Configure console keymap
	console.keyMap = "br-abnt2";

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.m42 = {
		isNormalUser = true;
		description = "m42";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			vim
				firefox
				emacs
				terminator
				arandr
######FONTS######
				noto-fonts
				noto-fonts-cjk
				noto-fonts-emoji
				liberation_ttf
				fira-code
				fira-code-symbols
				mplus-outline-fonts.githubRelease
				dina-font
				proggyfonts
				(nerdfonts.override{fonts=["FiraCode" "DroidSansMono"];})
arandr
################
		];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#  wget
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
#services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?
}
