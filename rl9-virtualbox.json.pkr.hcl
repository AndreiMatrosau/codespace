locals {
  version = formatdate("YYYY.MM.DD", timestamp())
}

source "qemu" "rl9" {
  iso_url           = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
  iso_checksum      = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
  output_directory  = "output-rocky_linux"
  shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
  disk_size         = "40000M"
  memory            = "2048"
  format            = "qcow2"
  accelerator       = "kvm"
  http_directory    = "http"
  ssh_username      = "packer"
  ssh_password      = "s0m3password"
  ssh_timeout       = "20m"
  vm_name           = "rockylinux9"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  display           = "none"
  headless          = true
  boot_command      = [
    "<tab><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
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
