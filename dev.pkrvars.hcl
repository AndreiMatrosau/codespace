scripts                          = ["install_ansible.sh"]
shared_image_gallery_destination = {
    subscription         = "/subscriptions/c6a76d9c-0f67-4a42-b2a1-3defb05f2aae/resourceGroups/rg-packer/providers/Microsoft.Compute/galleries/sig.packer"
    resource_group       = "rg-packer"
    gallery_name         = "sig.packer"
    image_name           = "rl9-X86_64"
    image_version        = "0.1.0"
    replication_regions  = []
    storage_account_type = "Standard_LRS"
}