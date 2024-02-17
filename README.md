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
brew install qemu
qemu-system-x86_64 --version
qemu-img convert -f raw -O vpc /path/to/your.iso /path/to/your.vhd
az storage blob upload --account-name mystorageaccount --container-name mycontainer --name mydisk.vhd --type page --file ./path/to/mydisk.vhd
az disk create --resource-group myResourceGroup --name myDisk --source https://mystorageaccount.blob.core.windows.net/mycontainer/mydisk.vhd
az vm create --resource-group myResourceGroup --name myVM --attach-os-disk myDisk --os-type linux
