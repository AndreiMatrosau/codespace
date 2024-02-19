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

