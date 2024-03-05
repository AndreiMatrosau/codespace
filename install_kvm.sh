#!/bin/bash
sudo apt-get update
sudo apt-get install qemu qemu-kvm libvirt-daemon-system -y
sudo apt-get install libvirt-clients virt-manager bridge-utils -y
sudo usermod -aG kvm $USER
sudo chmod 666 /dev/kvm
sudo addgroup libvirtd
sudo usermod -aG libvirtd $USER
sudo adduser $USER libvirt
echo 'KERNEL=="kvm", GROUP="kvm", MODE="0660"' | sudo tee /etc/udev/rules.d/99-kvm.rules
sudo udevadm control --reload-rules
sudo systemctl restart libvirtd
export DISPLAY=