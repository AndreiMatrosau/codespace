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
```

```bash
text
lang en_US.UTF-8
keyboard --vckeymap=de
timezone --utc Etc/UTC
selinux --disabled
eula --agreed
firstboot --disable
rootpw "moep123!"
reboot
 
url --url="http://dl.rockylinux.org/pub/rocky/9/BaseOS/aarch64/os/"
repo --name="AppStream" --baseurl=http://dl.rockylinux.org/pub/rocky/9/AppStream/aarch64/os
 
bootloader --location=mbr --append="net.ifnames=0 consoleblank=3600 rhgb quiet"
zerombr
clearpart --all --initlabel
part /boot/efi --fstype=efi --size=1024 --ondisk=sda  --label=efi
part /boot --size=1024 --fstype=ext4 --ondisk=sda  --label=boot --asprimary --fsoptions="rw,nodev,noexec,nosuid"
part pv.01 --size=40960 --ondisk=sda --fstype="lvmpv" --encrypted --passphrase=changeme
volgroup vg_gebos pv.01
logvol swap --name=swap --vgname=vg_gebos --fstype=swap --size=4096
logvol / --name=root --vgname=vg_gebos --fstype=xfs --size=8192 --fsoptions="noatime"
logvol /home --name=home --vgname=vg_gebos --fstype=ext4 --size=1024 --fsoptions="noatime"
logvol /var/log --name=log --vgname=vg_gebos --fstype=ext4 --size=1024 --fsoptions="noatime"
logvol /var/tmp --name=tmp --vgname=vg_gebos --fstype=ext4 --size=1024 --fsoptions="noatime"
logvol /var --name=var --vgname=vg_gebos --fstype=ext4 --size=1 --grow --maxsize=40960 --fsoptions="noatime"
 
 
%packages
@^minimal-environment
-cronie*
-crontabs
-iw*-firmware
-kexec-tools
-selinux-policy*
%end
```