qemuargs = [
  {
    type = "-netdev",
    value = ["user,id=user.0,", "hostfwd=tcp::{{ .SSHHostPort }}-:22,"]
  },
  {
    type = "-device",
    value = ["virtio-net,netdev=user.0"]
  }
]

iso_url              = "https://download.rockylinux.org/pub/rocky/9.3/isos/x86_64/Rocky-9.3-x86_64-boot.iso"
iso_checksum         = "sha256:eb096f0518e310f722d5ebd4c69f0322df4fc152c6189f93c5c797dc25f3d2e1"
iso_target_path      = "iso/Rocky-9.3-x86_64.iso"
output_directory     = "output_rl9"
shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
shutdown_timeout     = "10m"
cpu_model            = "host"
memory               = "4096"
disk_size            = "40000M"
format               = "qcow2"
accelerator          = "kvm"
communicator         = "ssh"
headless             = true
display              = "none"
http_directory       = "http"
ssh_username         = "packer"
ssh_password         = "packer"
ssh_private_key_file = "ssh/id_rsa"
ssh_timeout          = "40m"
ssh_pty              = true
vm_name              = "rocky9"
net_device           = "virtio-net"
disk_interface       = "virtio"
boot_wait            = "1s"
boot_key_interval    = "1ms"
boot_command         = ["<up><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/packer-Rocky9.cfg<enter><wait3s>"]