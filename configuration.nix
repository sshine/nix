{ modulesPath, ... }: {
  imports = [
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    # ./sops.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "feng";
  networking.domain = "mechanicus.xyz";

  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINk9vVXS7EQYBFKKLQTRSEKpjsVvKKmYcuCZlPLzOqSa''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2aLVgYzvZoWSCURE54JAP0f3oSiIoTNRullHoJYN6z sshine@zhen''
  ];

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };

  system.stateVersion = "23.11";
}
