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

**************************************************

az login --service-principal -u f2e13f0f-6d58-40ce-9dcb-9cb2debf2720 -p XXZ8Q~TEk-2hbhQXVP_6sNIIs~VlIXFzhi40Wb2A --tenant 5d3251b2-c53f-47e1-95c0-378922d5c244 && az account set -s 4f2af214-7051-4dc8-93d1-5576e645e91c
  resourceGroup="rg-itis-dev-wingetrepo"
  appName="itiswingetrepo-func"
  zipArchiveFullPath="~/Downloads/WinGet.RestSource.Functions.zip"
  az functionapp deployment source config-zip -g $resourceGroup -n $appName  --src $zipArchiveFullPath
  -------------
  ssh-keygen -t rsa -b 4096 -m PEM

  /home/user/Documents/Projects/Gebit/kikstartworkflow/ssh



 /usr/bin/qemu-system-x86_64: []string{"-machine", "type=pc,accel=kvm", "-m", "4096M", "-display", "gtk", "-drive", "file=output_rl9_test/rocky9.3test,if=virtio,cache=writeback,discard=ignore,format=qcow2", "-drive", "file=iso/Rocky-9.3-test-x86_64.iso,media=cdrom", "-drive", "file=/usr/share/OVMF/OVMF_CODE.fd,if=pflash,unit=0,format=raw,readonly=on", "-drive", "file=output_rl9_test/efivars.fd,if=pflash,unit=1,format=raw", "-smp", "1", "-cpu", "host", "-netdev", "user,id=user.0,hostfwd=tcp::2517-:22,", "-device", "virtio-net,netdev=user.0", "-vnc", "127.0.0.1:7", "-name", "rocky9.3test"}

************************************

az group create --name rg-packer-vm --location northeurope
az storage account create --name sarocky9vhd --resource-group rg-packer-vm --location northeurope --sku Standard_LRS --allow-blob-public-access true
az storage container create --name sarocky9vhdcontainer --account-name sarocky9vhd


packer validate rl9efi.pkr.hcl
PACKER_LOG=1 packer build rl9efi.pkr.hcl

///////////////////////////////////////
qemu-img convert -f qcow2 -o subformat=fixed,force_size -S 0 -O vpc output/rocky9.3 rocky9.3.vhd -p

az storage blob upload --account-name sarocky9vhd --container-name sarocky9vhdcontainer --name rocky9.3.vhd --type page --file rocky9.3.vhd --overwrite true


/////////////////////////////////
az disk create --resource-group rg-packer-vm --name rocky9.3.vhd --source https://sarocky9vhd.blob.core.windows.net/sarocky9vhdcontainer/rocky9.3.vhd
az vm create --resource-group rg-packer-vm --location northeurope --name rl9-efi --size Standard_DS2_v2 --attach-os-disk rocky9.3.vhd --os-type linux

-----------------
az vm create -g rg-packer-vm -n rl9computegallery --image /subscriptions/c6a76d9c-0f67-4a42-b2a1-3defb05f2aae/resourceGroups/rg-packer-vm/providers/Microsoft.Compute/galleries/qemucomputegallery/images/rockylinux9/versions/0.1.0 --specialized
-----------------


qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=rocky9.3 -cpu host -m 8G -smp 4 -enable-kvm -hda rocky9.3 -netdev user,id=usernet0 -device virtio-net,netdev=usernet0 -display gtk -vga std


sed -i 's+ExecStart=-\/sbin\/agetty -o '-p -- \\u' --noclear - $TERM+ExecStart=-\/sbin\/agetty --noclear --autologin root - $TERM+' file >> file.bak

qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=rocky9.3 -cpu host -m 8G -smp 4 -enable-kvm -hda rocky9.3 -netdev bridge,id=hn1 -device virtio-net,netdev=hn1,mac=e6:c8:ff:09:76:99 -display gtk -vga std




qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=output/rocky9.3 -cpu host -m 8G -smp 4 -enable-kvm -hda output/rocky9.3 -netdev user,id=usernet0,hostfwd=tcp::3777-:22 -device virtio-net-pci,netdev=usernet0 -display gtk -vga std

----
qemu-system-x86_64: []string{"-device", "virtio-net-pci,netdev=user.0", "-vnc", "127.0.0.1:75", "-name", "rocky9.3", "-m", "8192M", "-smp", "1", "-netdev", "user,id=user.0,hostfwd=tcp::2222-:22,", "-display", "gtk", "-drive", "file=output/rocky9.3,if=virtio,cache=writeback,discard=ignore,format=qcow2", "-drive", "file=iso/Rocky-9.3-test-x86_64.iso,media=cdrom", "-drive", "file=/usr/share/OVMF/OVMF_CODE.fd,if=pflash,unit=0,format=raw,readonly=on", "-drive", "file=output/efivars.fd,if=pflash,unit=1,format=raw", "-machine", "type=pc,accel=kvm", "-cpu", "host"}

*************************
qemu-img convert -f qcow2 -o subformat=fixed,force_size -S 0 -O vpc output/rocky9.3 rocky9.3.headless.vhd -p


az storage blob upload --account-name sarocky9vhd --container-name sarocky9vhdcontainer --name rocky9.3.vhd --type page --file rocky9.
3.headless.vhd --overwrite true

az disk create --resource-group rg-packer-vm --name rocky9.3.vhd --source https://sarocky9vhd.blob.core.windows.net/sarocky9vhdcontainer/rocky9.3.vhd
======================================
az vm create -g rg-packer-vm -n rl9.3-cg-v0.2.0 --image /subscriptions/c6a76d9c-0f67-4a42-b2a1-3defb05f2aae/resourcegroups/rg-packer-vm/providers/Microsoft.Compute/galleries/qemucomputegallery/images/rockylinux9/versions/0.2.0 --specialized
======================================




az disk create --resource-group rg-packer-vm --name rocky9.3.test.vhd --source https://sarocky9vhdga.blob.core.windows.net/sarocky9vhdcontainerga/rocky9.3.vhd
az vm create --resource-group rg-packer-vm --location northeurope --name rl9-efi-test --size Standard_DS2_v2 --attach-os-disk rocky9.3.test.vhd --os-type linux

*****************************************************************************************************************************************************************29.02.2024
packer validate -var-file="dev.pkrvars.hcl" -var 'ssh_private_key_file=ssh/rocky' .
PACKER_LOG=1 packer build -var-file="dev.pkrvars.hcl" -var 'ssh_private_key_file=ssh/rocky' .


qemu-img convert -f qcow2 -o subformat=fixed,force_size -S 0 -O vpc output/rocky9.3 rocky9.3.vhd -p
qemu-img convert -f qcow2 -o subformat=fixed,force_size -S 0 -O vpc output_rl9/rocky9.3 rocky9.3c.vhd -p


az group create --name rg-packer-vm-test --location northeurope
az storage account create --name sarocky9vhdtest --resource-group rg-packer-vm-test --location northeurope --sku Standard_LRS --allow-blob-public-access true
az storage container create --name sarocky9vhdcontainertest --account-name sarocky9vhdtest


az storage blob upload --account-name sarocky9vhdtest --container-name sarocky9vhdcontainertest --name rocky9.3.vhd --type page --file rocky9.3.vhd --overwrite true
az storage blob upload --account-name sarocky9vhdtest --container-name sarocky9vhdcontainertest --name rocky9.3c.vhd --type page --file rocky9.3c.vhd --overwrite true

az disk create --resource-group rg-packer-vm-test --name rocky9.3.vhd --source https://sarocky9vhdtest.blob.core.windows.net/sarocky9vhdcontainertest/rocky9.3.vhd
az disk create --resource-group rg-packer-vm-test --name rocky9.3c.vhd --source https://sarocky9vhdtest.blob.core.windows.net/sarocky9vhdcontainertest/rocky9.3c.vhd

az vm create --resource-group rg-packer-vm-test --location northeurope --name rl9-efi-test --size Standard_DS2_v2 --attach-os-disk rocky9.3.vhd --os-type linux
az vm create --resource-group rg-packer-vm-test --location northeurope --name rl9c-efi-test --size Standard_DS2_v2 --attach-os-disk rocky9.3c.vhd --os-type linux



az sig create --resource-group rg-packer-vm-test --gallery-name rl9efigallery --location northeurope


az sig image-definition create --resource-group rg-packer-vm-test --gallery-name rl9efigallery --gallery-image-definition rl9img --publisher custompublisher --offer customoffer --sku customsku --os-type Linux --os-state specialized --hyper-v-generation V2

az sig image-version create --resource-group rg-packer-vm-test --gallery-name rl9efigallery --gallery-image-definition rl9img --gallery-image-version 1.0.0 --target-regions northeurope --replica-count 1 --os-vhd-storage-account sarocky9vhdtest --os-vhd-uri https://sarocky9vhdtest.blob.core.windows.net/sarocky9vhdcontainertest/rocky9.3.vhd --storage-account-type Premium_LRS

az vm create --resource-group ${{ env.RESOURCE_GROUP_NAME }} --location ${{ env.LOCATION }} --name ${{ env.VM_NAME }} --image ${IMAGE_ID} --specialized
**********************************************************************************************************************************************************************
