variable "azure_tags" {
  type        = map(string)
  description = "Name/value pair tags to apply to every resource deployed."
  default = {
    env = "dev"
  }
}

variable "client_id" {
  type        = string
  description = "The application ID of the AAD Service Principal."
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "A password/secret registered for the AAD SP."
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "The Active Directory tenant identifier with which client_id and subscription_id are associated."
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "The subscription to use."
  sensitive   = true
}

variable "os_type" {
    type        = string
    description = "If either Linux or Windows is specified Packer will automatically configure authentication credentials for the provisioned machine."
    default     = "Linux"
}

variable "image_offer" {
    type        = string
    description = "Name of the publisher's offer to use for your base image (Azure Marketplace Images only)."
    default     = "rockylinux-x86_64"
}

variable "image_publisher" {
    type        = string
    description = "Name of the publisher to use for your base image (Azure Marketplace Images only)."
    default     = "resf"
}

variable "image_sku" {
    type        = string
    description = "SKU of the image offer to use for your base image (Azure Marketplace Images only)."
    default     = "rockylinux-x86_64-9"
}

variable "location" {
  type        = string
  description = "Azure datacenter in which your VM will build."
  default     = "North Europe"
}

variable "temp_resource_group_name" {
  type        = string
  description = "Name assigned to the temporary resource group created during the build."
  default     = "rg-temp-packer-vm-build"
}

variable "managed_image_name" {
  type        = string
  description = "Specify the managed image name where the result of the Packer build will be saved."
}

variable "managed_image_resource_group_name" {
  type        = string
  description = "Specify the managed image resource group name where the result of the Packer build will be saved."
}

variable "vm_size" {
  type        = string
  description = "Size of the VM used for building."
  default     = "Standard_DS2_v2"
}

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

variable "execute_command" {
  type        = string
  description = "The command to use to execute the script."
  default     = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
}

variable "scripts" {
  type        = list(string)
  description = "An array of scripts to execute. The scripts will be uploaded and executed in the order specified."
  default     = []
}