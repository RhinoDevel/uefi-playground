#!/bin/sh

# KiB, MiB, GiB: Base = 1024
# kB, MB, GB: Base = 1000

# dd: bs * count = bytes
#
# => 512 * 93750 = 48000000 = 48MB
#
dd if=/dev/zero of=uefi.img bs=512 count=93750

/sbin/parted uefi.img -s -a minimal mklabel gpt

# s for sector, assuming one sector to be of size 512 bytes.
#
# start and end are offsets from beginning of disk.
#
# => 2048s = 2048 * 512 = 1MiB offset from beginning of disk.
#
# => 93750 - 93716 = 34
#    34 * 512 = 17KiB free behind EFI partition.
#
/sbin/parted uefi.img -s -a minimal mkpart EFI FAT32 2048s 93716s

# Shouldn't be necessary:
#
#/sbin/parted uefi.img -s -a minimal toggle 1 boot

dd if=/dev/zero of=part.img bs=512 count=91669

# Fill floppy disk image with MSDOS file system:
#
# -h = Heads
# -t = Cylinders
# -n = Sectors
# -c = Cluster size
# -F = FAT32
#
mformat -i part.img -h 32 -t 32 -n 128 -c 1 -F

# Add folders to floppy disk image's file system:
#
mmd -i part.img ::/EFI
mmd -i part.img ::/EFI/BOOT
