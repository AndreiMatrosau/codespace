#!/bin/bash
sudo qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=output_rl9/rocky9.3 -cpu host -m 4G -smp 2 -enable-kvm -hda output_rl9/rocky9.3 -netdev user,id=usernet0,hostfwd=tcp::3777-:22 -device virtio-net-pci,netdev=usernet0 -display none -vga none
ssh -V -o StrictHostKeyChecking=no -i $1 -p 3777 localhost 'bash -s' < $2 > $3
# Kill the firecracker process to exit the workflow
sleep 20
for i in $( ps ax | awk '/qemu*/ {print $1}' ); do kill -9 ${i}; done