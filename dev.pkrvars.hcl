qemuargs = [
  ["-netdev", "user,id=user.0,",
    "hostfwd=tcp::{{ .SSHHostPort }}-:22,",
  ],
  ["-device", "virtio-net-pci,netdev=user.0"]
]

iso_url              = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
iso_checksum         = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
iso_target_path      = "iso/Rocky-9.3-x86_64.iso"
output_directory     = "output_rl9"
shutdown_command     = "sudo /usr/sbin/shutdown -h now"
http_directory       = "http"
ssh_username         = "rocky"
ssh_password         = "azureuser"
vm_name              = "rocky9.3"