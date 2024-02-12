managed_image_name                = "rl9-X86_64"
managed_image_resource_group_name = "rg-packer"
scripts                           = ["install_ansible.sh"]
shared_image_gallery_destination  = {
#    subscription         = "c6a76d9c-0f67-4a42-b2a1-3defb05f2aae"
    resource_group       = "rg-packer"
    gallery_name         = "sig.packer"
    image_name           = "rl9-X86_64"
    image_version        = "1.9.0"
    replication_regions  = ["North Europe"]
    storage_account_type = "Standard_LRS"
}