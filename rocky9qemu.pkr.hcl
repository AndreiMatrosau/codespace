source "qemu" "rl9" {
  qemuargs             = [
    ["-netdev", "user,id=user.0,",
      "hostfwd=tcp::{{ .SSHHostPort }}-:22,",
    ],
    ["-device", "virtio-net,netdev=user.0"]
  ]
  efi_boot             = true
  efi_firmware_code    = "/usr/share/OVMF/OVMF_CODE.fd"
  efi_firmware_vars    = "/usr/share/OVMF/OVMF_VARS.fd"
  // machine_type         = "q35"
  iso_url              = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
  iso_checksum         = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
  iso_target_path      = "iso/Rocky-9.3-test-x86_64.iso"
  output_directory     = "output"
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
  shutdown_timeout     = "1m"
  cpu_model            = "host"
  memory               = "4096"
  disk_size            = "30720M"
  format               = "qcow2"
  accelerator          = "kvm"
  communicator         = "ssh"
  headless             = true
  display              = "none"
  http_directory       = "http"
  ssh_username         = "root"
  ssh_password         = "azureUser123"
  // ssh_private_key_file = "ssh/ed215"
  ssh_timeout          = "40m"
  ssh_pty              = true
  vm_name              = "rocky9.3"
  net_device           = "virtio-net"
  disk_interface       = "virtio"
  boot_wait            = "5s"
  boot_key_interval    = "5ms"
  boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/packer-Rocky9.cfg.cfg<leftCtrlOn>x<leftCtrlOff><wait3s>"]
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
