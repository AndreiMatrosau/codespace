locals {
  version = formatdate("YYYY.MM.DD", timestamp())
}

source "qemu" "rl9" {
  vm_name                = "rockylinux9"
  qemuargs               = [
    [
      "-cpu", "host",
      "displ
    ]
  ]
  accelerator            = "kvm"
  cd_label               = "OEMDRV"
  cpus                   = "2"
  memory                 = "4096"
  disk_interface         = "virtio"
  disk_size              = "20G"
  format                 = "qcow2"
  iso_url                = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
  iso_checksum           = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
  // iso_target_path        = "iso/Rocky-9.3-x86_64-boot.iso"
  iso_target_extension   = "iso"
  http_directory         = "http"
  communicator           = "ssh"
  ssh_port               = 22
  ssh_pty               = true
  ssh_username           = "packer"
  ssh_password         = "s0m3password"
  // ssh_private_key_file   = "./ssh/id_rsa"
  ssh_timeout            = "30m"
  ssh_handshake_attempts = 2
  host_port_min           = 2222
  host_port_max           = 2229
  pause_before_connecting = "60s"
  net_device             = "virtio-net-pci"
  headless               = true
  display                = "none"
  output_directory       = "output-rocky_linux"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  boot_wait              = "10s"  
  boot_command           = [
    "<tab> sshd text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/http/ks.cfg<enter><wait>"
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
    sshkey = {
      version = ">= 1.1.0"
      source = "github.com/ivoronin/sshkey"
    }
  }
}
