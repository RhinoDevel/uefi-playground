
/*

GNU-EFI

- Source: http://wiki.osdev.org/UEFI#UEFI_vs._legacy_BIOS

- apt-get install gnu-efi

=>

/usr/include/efi
/usr/include/efi/x86_64

/usr/lib

- non-free apt source necessary for: apt-get install ovmf

=>

/usr/share/ovmf/OVMF.fd

- apt-get install mtools

*/

#include <efi.h>
#include <efilib.h>

EFI_STATUS
EFIAPI
efi_main (EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
  InitializeLib(ImageHandle, SystemTable);
  SystemTable->BootServices->SetWatchdogTimer(0, 0, 0, NULL);
  while(1)
  {
      Print(L"Hello, world!\n");
  }
  return EFI_SUCCESS;
}
