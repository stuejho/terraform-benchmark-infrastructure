resource "proxmox_vm_qemu" "virtual_machines" {
  count = 1
  name = "benchmark-${count.index + 1}"
  desc = "Storage benchmarking VM"
  target_node = var.proxmox_host
  
  clone = var.vm_template_name
  
  # VM System Settings
  agent = 1
  
  # VM Basic Settings
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  bootdisk = "scsi0"
  
  # VM Network Settings
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  ipconfig0 = "ip=10.1.1.${count.index + 101}/24,gw=10.1.1.1"

  disk {
    storage = "local-lvm"
    type = "scsi"
    size = "10G"
  }
  
  # VM Cloud-Init Settings
  os_type = "cloud-init"
  
  # Set ssh key
  sshkeys = var.ssh_key
}