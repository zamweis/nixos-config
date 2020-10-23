# Config

## Machine Hostnames

- Main PC
  - galaxy
- Lenovo ThinkPad E470
  - nebula

## Installation

Note: First install NixOS with the defaults from `nixos-generate-config --root /mnt` (after partitioning). The only thing to add is the hostname (see list above).

### Nebula

#### Partitioning

```bash
NAME                MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                   8:0    0 238.5G  0 disk
├─sda1                8:1    0   512M  0 part  /boot/efi
└─sda2                8:2    0   238G  0 part
  └─root            254:0    0   238G  0 crypt
    ├─SystemVG-swap 254:1    0    24G  0 lvm   [SWAP]
    └─SystemVG-root 254:2    0   214G  0 lvm   /
```

```bash
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB # efi
parted /dev/sda -- mkpart primary 512MiB 100% # root
parted /dev/sda -- set 1 boot on
```

- A boot partition outside of the LUKS partition
- LVM on LUKS for swap and root

#### Generate key for single password unlock

```bash
dd if=/dev/urandom of=/crypt_keyfile.bin bs=1024 count=4
```

#### Setup LUKS and add the keys

```bash
cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha512 /dev/sda2
cryptsetup luksAddKey /dev/sda2 crypt_keyfile.bin
cryptsetup luksOpen /dev/sda2 crypt-nixos
```

#### Setup LVM

```bash
pvcreate /dev/mapper/crypt-nixos
vgcreate system-vg /dev/mapper/crypted-nixos
lvcreate -L 24G -n swap system-vg
lvcreate -l '100%FREE' -n root system-vg
```

#### Formatting

```bash
mkfs.fat -F 32 -n boot /dev/sda1
mkswap -L swap /dev/system-vg/swap
mkfs.ext4 -L nixos /dev/system-vg/root
```

#### Mounting

```bash
mount /dev/system-vg/root /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/system-vg/swap
```

#### Create an initrd which only contains the keyfile

Note: `pushd` and `popd` are only reminder for myself incase I write a script someday

```bash
pushd /mnt
find crypt_keyfile.bin -print0 | cpio -o -H newc -R +0:+0 --reproducible --null | gzip -9 > /mnt/boot/initrd.key.gz
chmod 000 /mnt/boot/initrd.keys.gz
popd
```

#### Generate configuration

```
nixos-generate-config --root /mnt
```

Add following lines:

```nix
boot = {
  loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  loader.efi.efiSysMountPoint = "/boot/efi";
  initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-label/nixos";
      preLVM = true;
      keyFile = "/crypt_keyfile.bin";
      allowDiscards = true;
    };
  };
  initrd.prepend = [
    "${/boot/initrd.key.gz}"
  ];
};
```


## Setup NixOS (all with root user)

1. Clone this to /config
2. Install channels

```bash
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

3. Setup configuration

```bash
mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
ln -sf /config/etc/nix/configuration.nix /etc/nixos/configuration.nix
```

## Setup (Home Manager)

After a reboot the user(s) should have been created, copy the home manager config into the home directory:

```bash
ln -sf /config/home/vincentcui/home-manager/home.nix ~/.config/nixpkgs/home.nix
```

You can try it out with `home-manager switch`
