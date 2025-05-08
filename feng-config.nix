{ pkgs, modulesPath, ... }: {
  imports = [
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./home-manager.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  services.radicle.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "feng";
  networking.domain = "mechanicus.xyz";

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };

  system.stateVersion = "23.11";
}
