variable "qemuargs" {
  type = list(object({
    type = string
    value = list(string)
  }))
  description = <<EOT
    Allows complete control over the qemu command line (though not qemu-img).
  EOT
  default = []
}

variable "iso_url" {}

variable "iso_checksum" {}

variable "iso_target_path" {}

variable "output_directory" {}

variable "shutdown_command" {}
variable "shutdown_timeout" {}
variable "cpu_model" {}
variable "memory" {}
variable "disk_size" {}
variable "format" {}
variable "accelerator" {}
variable "communicator" {}
variable "headless" {}
variable "display" {}
variable "http_directory" {}
variable "ssh_username" {}
variable "ssh_password" {}
variable "ssh_private_key_file" {}
variable "ssh_timeout" {}
variable "ssh_pty" {}
variable "vm_name" {}
variable "net_device" {}
variable "disk_interface" {}
variable "boot_wait" {}
variable "boot_key_interval" {}
variable "boot_command" {}
variable "qemu_version" {}
variable "qemu_source" {}
