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

variable "iso_url" {
  type        = string
  description = "A URL to the ISO containing the installation image or virtual hard drive (VHD or VHDX) file to clone."
}

variable "iso_checksum" {
  type        = string
  description = "The checksum for the ISO file or virtual hard drive file.
}

variable "iso_target_path" {
  type        = string
  description = "The path where the iso should be saved after download."
  default     = ""
}

variable "output_directory" {
  type        = string
  description = "The path to the directory where the resulting virtual machine will be created."
  default     = ""
}

variable "shutdown_command" {
  type        = string
  description = "The command to use to gracefully shut down the machine once all provisioning is complete."
  default     = ""
}

variable "shutdown_timeout" {
  type        = string
  description = "The amount of time to wait after executing the shutdown_command for the virtual machine to actually shut down."
  default     = "0h10m0s"
}

variable "cpu_model" {
  type        = string
  description = "The CPU model is what will be used by qemu for booting the virtual machine and determine which features of a specific model/family of processors is supported"
  default     = "host"
}

variable "memory" {
  type        = int
  description = "The amount of memory to use when building the VM in megabytes."
  default     = 4096
}

variable "disk_size" {
  type        = string
  description = "The size in bytes of the hard disk of the VM."
  default     = "40960M"
}

variable "format" {
  type        = string
  description = "Either qcow2 or raw, this specifies the output format of the virtual machine image."
  default     = "qcow2"
}

variable "accelerator" {
  type        = string
  description = "The accelerator type to use when running the VM."
  default     = "kvm"
}

variable "communicator" {
  type        = string
  description = "The mechanism Packer uses to upload files, execute scripts, etc. on the machine being created, and are configured within the builder section."
  default     = "ssh"
}

variable "headless" {
  type        = bool
  description = "Packer defaults to building QEMU virtual machines by launching a GUI that shows the console of the machine being built."
  default     = true
}

variable "display" {
  type        = string
  description = "What QEMU -display option to use."
  default     = "none"
}

variable "http_directory" {
  type        = string
  description = "Path to a directory to serve using an HTTP server."
  default     = ""
}

variable "ssh_username" {
  type        = string
  description = 
  default     =
}

variable "ssh_password" {
  type        = string
  description = "The username to connect to SSH with. Required if using SSH."
}

variable "ssh_private_key_file" {
  type        = string
  description = "Path to a PEM encoded private key file to use to authenticate with SSH."
}

variable "ssh_timeout" {
  type        = string
  description = "The time to wait for SSH to become available."
  default     = "40m"
}

variable "ssh_pty" {
  type        = bool
  description = "If true, a PTY will be requested for the SSH connection."
  default     = true
}

variable "vm_name" {
  type        = string
  description = "This is the name of the image (QCOW2 or IMG) file for the new virtual machine."
  default     = "rocky9.3"
}

variable "net_device" {
  type        = string
  description = "The driver to use for the network interface."
  default     = "virtio-net"
}

variable "disk_interface" {
  type        = string
  description = "The interface to use for the disk."
  default     = "virtio"
}

variable "boot_wait" {
  type        = string
  description = "The time to wait after booting the initial virtual machine before typing the boot_command."
  default     = "1s"
}

variable "boot_key_interval" {
  type        = string
  description = "Time in ms to wait between each key press."
  default     = "1ms"
}

variable "boot_command" {
  type        = list(string)
  description = "This is an array of commands to type when the virtual machine is first booted."
  default     = ["<up><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/packer-Rocky9.cfg<enter><wait3s>"]
}
