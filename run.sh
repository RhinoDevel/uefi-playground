#!/bin/sh

mcopy -ovi part.img main.efi ::/
#cp main.efi BOOTX64.efi
#mcopy -ovi part.img BOOTX64.efi ::/EFI/BOOT/

dd if=part.img of=uefi.img bs=512 count=91669 seek=2048 conv=notrunc

qemu-system-x86_64 -cpu qemu64 -bios /usr/share/ovmf/OVMF.fd -drive file=uefi.img,if=ide
#qemu-system-x86_64 -cpu qemu64 -bios /usr/share/ovmf/OVMF.fd -drive file=uefi.img,if=ide -nographic
