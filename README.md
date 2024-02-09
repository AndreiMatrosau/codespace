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