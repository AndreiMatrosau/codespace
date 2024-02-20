variable "plan_info" {
  type = object({
    plan_name      = string
    plan_product   = string
    plan_publisher = string
  })
  description = <<EOT
    Used for creating images from Marketplace images.
    - plan_name (string)      - The plan name, required.
    - plan_product (string)   - The plan product, required.
    - plan_publisher (string) - The plan publisher, required. 
  EOT
  default = {
    plan_name      = "rockylinux-x86_64-9"
    plan_product   = "rockylinux-x86_64"
    plan_publisher = "resf"
  } 
}

variable "shared_image_gallery_destination" {
  type = object({
  #  subscription         = string
    resource_group       = string
    gallery_name         = string
    image_name           = string
    image_version        = string
    replication_regions  = list(string)
    storage_account_type = string
  })
  description = <<EOT
    Publishing a new image version to an existing shared image gallery.
  #  - subscription (string)          - Sig Destination Subscription
    - resource_group (string)        - Sig Destination Resource Group
    - gallery_name (string)          - Sig Destination Gallery Name
    - image_name (string)            - Sig Destination Image Name
    - image_version (string)         - Sig Destination Image Version
    - replication_regions ([]string) - A list of regions to replicate the image version in,
                                       by default the build location will be used as a replication region.
    - storage_account_type (string)  - Specify a storage account type for the Shared Image Gallery Image Version.
                                       Defaults to Standard_LRS.
  EOT
}

variable "provisioner_shell" {
  type = object({
    scripts = list(string)
  })
  description = <<EOT
    Provisions machines built by Packer using shell scripts.
    - scripts (list(string)) - An array of scripts to execute.
  EOT
  default = {
    scripts = []
  }  
}