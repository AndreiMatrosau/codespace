variable "azure_tags" {
  type = map(string)
  default = {
    env = "dev"
  }
}

variable "client_id" {
  type    = string
  default = "64dca93a-148e-4a35-aabc-8e05bd2b944f"
}

variable "client_secret" {
  type    = string
  default = "2eV8Q~Y-N1a2NuKr6.xYYcDtLn1eSxYXwY5kndvo"
}

variable "tenant_id" {
  type    = string
  default = "1ea1c520-b78c-4463-b9d4-d8d99073052c"
}

variable "subscription_id" {
  type    = string
  default = "c6a76d9c-0f67-4a42-b2a1-3defb05f2aae"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "managed_image_name" {
  type    = string
  default = "rl9"
}

variable "managed_image_resource_group_name" {
  type    = string
  default = "rg-packer"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "plan_name" {
  type    = string
  default = "rockylinux-x86_64-9"
}

variable "plan_product" {
  type    = string
  default = "rockylinux-x86_64"
}

variable "plan_publisher" {
  type    = string
  default = "resf"
}

variable "execute_command" {
  type    = string
  default = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
}

variable "provisioner_inline_commands" {
  type = list(string)
  default = [
    "dnf -y update",
    "dnf install -y epel-release",
    "dnf install ansible -y"
  ]
}

variable "inline_shebang" {
  type    = string
  default = "/bin/sh -x"
}