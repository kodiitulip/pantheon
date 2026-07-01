# { config, lib, pkgs, modulesPath, ... }:
{
  flake.nixosModules.persephone =
  { config, lib, modulesPath, ... }:
  {
    imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/14c18910-97d7-4cc8-838b-fda7c8c373a4";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/3BFA-BAC4";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/69fed19f-9ffe-47f7-b511-69f6c6bdbdd5";
      }
    ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
