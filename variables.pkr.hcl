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
  description = 
  default     =
}

variable "iso_checksum" {
  type        = string
  description = 
  default     =
}

variable "iso_target_path" {
  type        = string
  description = 
  default     =
}

variable "output_directory" {
  type        = string
  description = 
  default     =
}

variable "shutdown_command" {
  type        = string
  description = 
  default     =
}

variable "shutdown_timeout" {
  type        = string
  description = 
  default     =
}

variable "cpu_model" {
  type        = string
  description = 
  default     =
}

variable "memory" {
  type        = string
  description = 
  default     =
}

variable "disk_size" {
  type        = string
  description = 
  default     =
}

variable "format" {
  type        = string
  description = 
  default     =
}

variable "accelerator" {
  type        = string
  description = 
  default     =
}

variable "communicator" {
  type        = string
  description = 
  default     =
}

variable "headless" {
  type        = string
  description = 
  default     =
}

variable "display" {
  type        = string
  description = 
  default     =
}

variable "http_directory" {
  type        = string
  description = 
  default     =
}

variable "ssh_username" {
  type        = string
  description = 
  default     =
}

variable "ssh_password" {
  type        = string
  description = 
  default     =
}

variable "ssh_private_key_file" {
  type        = string
  description = 
  default     =
}

variable "ssh_timeout" {
  type        = string
  description = 
  default     =
}

variable "ssh_pty" {
  type        = string
  description = 
  default     =
}

variable "vm_name" {
  type        = string
  description = 
  default     =
}

variable "net_device" {
  type        = string
  description = 
  default     =
}

variable "disk_interface" {
  type        = string
  description = 
  default     =
}

variable "boot_wait" {
  type        = string
  description = 
  default     =
}

variable "boot_key_interval" {
  type        = string
  description = 
  default     =
}

variable "boot_command" {
  type        = string
  description = 
  default     =
}

variable "qemu_version" {
  type        = string
  description = 
  default     =
}

variable "qemu_source" {
  type        = string
  description = 
  default     =
}
