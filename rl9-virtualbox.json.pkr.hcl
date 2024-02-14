locals {
  version = formatdate("YYYY.MM.DD", timestamp())
}

data "sshkey" "packer" {}

source "qemu" "rl9" {
  accelerator       = "kvm"
  boot_command      = [
    "<tab><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
  cd_label             = "OEMDRV"
  boot_wait            = "10s"
  cpus                 = "2"
  memory               = "2048"
  disk_interface       = "virtio"
  disk_size            = "40G"
  format               = "qcow2"
  iso_url              = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
  iso_checksum         = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
  http_directory       = "http"
  communicator         = "ssh"
  ssh_username         = "packer"
  ssh_password         = "s0m3password"
  ssh_private_key_file = data.sshkey.packer.private_key_path
  ssh_timeout          = "5m"
  vm_name              = "rockylinux9"
  net_device           = "virtio-net"
  headless             = true
  display              = "none"
  output_directory     = "output-rocky_linux"
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
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
    sshkey = {
      version = ">= 1.1.0"
      source = "github.com/ivoronin/sshkey"
    }
  }
}
