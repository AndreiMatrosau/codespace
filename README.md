# Kickstart Installation

## Notes
The Image Definition has been to pre-stage in the Shared Image Gallery that are calling via the HashiCorp Packer template.

The options to do so:

- Use Terraform's `azurerm_shared_image` resource to create these definitions when the shared image gallery is created.

- Use az cli or PowerShell to create a shared image definition:

```bash
az sig image-definition create \
    --resource-group <resource_group_name> \
    --gallery-name <shared_image_gallery_name> \
    --gallery-image-definition <image_name> \
    --publisher <image_publisher_name> \
    --offer <image_offer> \
    --sku <image_sku> \
    --os-type linux


```bash
qemu-img convert -f qcow2 -o subformat=fixed,force_size -O vpc rocky9 rocky9-fixed.vhd -p
az storage blob upload --account-name packerrockylinux9 --container-name packerrockylinux9 --name rocky9-fixed.vhd --type page --file ./rocky9-fixed.vhd
az disk create --name rockyLinuxDisk --resource-group rg-packer --source https://packerrockylinux9.blob.core.windows.net/packerrockylinux9/rocky9-fixed.vhd
az vm create --resource-group rg-packer --location eastus --name rockylinux9 --attach-os-disk rockyLinuxDisk --os-type linux
az ssh vm --resource-group rg-packer --vm-name rockylinux9 --subscription c6a76d9c-0f67-4a42-b2a1-3defb05f2aae
```
```bash
# Linux
QEMU_PARAM_ACCELERATOR = -enable-kvm
QEMU_PARAM_UEFI_BIOS = -bios /usr/share/qemu/OVMF.fd
 
# MacOS + Intel CPU
QEMU_PARAM_ACCELERATOR = -accel hvf
 
# MacOS + Apple Silicon
QEMU_PARAM_ACCELERATOR = -accel tcg,thread=multi -smp cpus=4,sockets=1,cores=4,threads=1
 
# MacOS 
QEMU_FOLDER_LINK := $(shell brew --prefix qemu)
QEMU_FOLDER := $(shell readlink -f ${QEMU_FOLDER_LINK})
QEMU_PARAM_UEFI_BIOS = -drive if=pflash,format=raw,unit=0,file=${QEMU_FOLDER}/share/qemu/edk2-x86_64-code.fd,readonly=on
 
QEMU_DEFAULT_CMD = qemu-system-x86_64 \
	-cpu max \
	${QEMU_PARAM_ACCELERATOR} \
	-m 2G \
	-chardev socket,id=chrtpm,path=/tmp/swtpm/swtpm-sock \
	-tpmdev emulator,id=tpm0,chardev=chrtpm \
	-device tpm-tis,tpmdev=tpm0 \
	-device qemu-xhci \
	-drive format=raw,id=drive1,if=none,file=/tmp/soe.img \
	-device e1000e,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22
 
$(QEMU_DEFAULT_CMD) \
	${QEMU_PARAM_UEFI_BIOS} \
	-device ide-hd,bootindex=1,drive=drive1 \
	-drive format=raw,id=drive2,if=none,file=$(BUILD_DIR)/$(SOE_IMAGE) \
	-device usb-storage,bootindex=2,drive=drive2
```
