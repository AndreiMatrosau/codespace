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

locals {
  version = formatdate("YYYY.MM.DD", timestamp())
}

source "qemu" "rl9" {
  accelerator          = "kvm"
  qemuargs = [
    [
      // "-netdev", "user,id=user.0,hostfwd=tcp::{{ .SSHHostPort }}-:22, dhcpstart=192.168.0.10",
      // "-device", "virtio-net,netdev=user.0",
      "-cpu", "host"
    ]
  ]
  vm_name              = "rockylinux9"
  cpus                 = "2"
  memory               = "4096"
  disk_interface       = "virtio"
  disk_size            = "40G"
  format               = "qcow2"
  iso_url              = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
  iso_checksum         = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
  iso_target_path      = "iso/Rocky-9.3-x86_64-boot.iso"
  iso_target_extension = "iso"
  http_directory       = "http"
  headless             = true
  display              = "none"
  output_directory     = "output-rocky_linux"
  net_device           = "virtio-net"
  communicator         = "ssh"
  ssh_username         = "packer"
  ssh_password         = "s0m3password"
  ssh_timeout          = "40m"
  ssh_handshake_attempts = "10"
  ssh_port             = 22
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
  boot_key_interval    = "2ms"
  boot_wait            = "1s"
  boot_command         = [
    "<up><tab> inst.sshd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/http/ks.cfg <enter><wait>"
  ]
}

build {
  sources = ["source.qemu.rl9"]
}