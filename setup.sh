#!/bin/sh

# !!! Some UEFI hardware implementations require that the FAT image is in the FAT32 format (rather than FAT12 or FAT16). OVMF does not have this limitation, so you will not see such a problem in qemu. The minimum size of a FAT32 filesystem is, however, around 32 MiB so you will need to generate a much bigger image and pass the '-F' option to mformat. 
#
dd if=/dev/zero of=uefi.img bs=512 count=93750
#
/sbin/parted uefi.img -s -a minimal mklabel gpt
/sbin/parted uefi.img -s -a minimal mkpart EFI FAT16 2048s 93716s
/sbin/parted uefi.img -s -a minimal toggle 1 boot
#
dd if=/dev/zero of=part.img bs=512 count=91669
mformat -i part.img -h 32 -t 32 -n 64 -c 1
mmd -i part.img ::/EFI
mmd -i part.img ::/EFI/BOOT
