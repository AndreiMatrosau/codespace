source "azure-arm" "this" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  tenant_id                         = var.tenant_id
  subscription_id                   = var.subscription_id

  os_type                           = "${var.os_type}"
  image_offer                       = "${var.image_offer}"
  image_publisher                   = "${var.image_publisher}"
  image_sku                         = "${var.image_sku}"

  location                          = "${var.location}"
  temp_resource_group_name          = var.temp_resource_group_name
  vm_size                           = "${var.vm_size}"
  
  azure_tags                        = "${var.azure_tags}"

  managed_image_name                = "${var.managed_image_name}"
  managed_image_resource_group_name = "${var.managed_image_resource_group_name}"

  plan_info {
    plan_name      = "${var.plan_name}"
    plan_product   = "${var.plan_product}"
    plan_publisher = "${var.plan_publisher}"
  }
}

build {
  sources = ["source.azure-arm.this"]

  provisioner "shell" {
    execute_command = "${var.execute_command}"
    inline          = "${var.provisioner_inline_commands}"
#    inline_shebang  = "${var.inline_shebang}"
    scripts         = $var.scripts
  }
}

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 2.0.2"
    }
  }
}
