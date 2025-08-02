{ pkgs, modulesPath, ... }: {
  imports = [
    ./common.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./home-manager.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.hostName = "feng";
  networking.domain = "mechanicus.xyz";

  services.radicle.enable = true;
  services.vaultwarden.enable = true;

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };

  system.stateVersion = "23.11";
}
