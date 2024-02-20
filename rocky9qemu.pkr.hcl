source "qemu" "rl9" {
  qemuargs             = var.qemuargs
  iso_url              = var.iso_url
  iso_checksum         = var.iso_checksum
  iso_target_path      = var.iso_target_path
  output_directory     = var.output_directory
  shutdown_command     = var.shutdown_command
  shutdown_timeout     = var.shutdown_timeout
  cpu_model            = var.cpu_model
  memory               = var.memory
  disk_size            = var.disk_size
  format               = var.format
  accelerator          = var.accelerator
  communicator         = var.communicator
  headless             = var.headless
  display              = var.display
  http_directory       = var.http_directory
  ssh_username         = var.ssh_username
  ssh_password         = var.ssh_password
  ssh_private_key_file = var.ssh_private_key_file
  ssh_timeout          = var.ssh_timeout
  ssh_pty              = var.ssh_pty
  vm_name              = var.vm_name
  net_device           = var.net_device
  disk_interface       = var.disk_interface
  boot_wait            = var.boot_wait
  boot_key_interval    = var.boot_key_interval
  boot_command         = var.boot_command
}

build {
  sources = ["source.qemu.rl9"]
}

packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}
