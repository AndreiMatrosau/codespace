#!/bin/bash
echo "Starting VM ..."
sudo qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=output_rl9/rocky9.3 -cpu host -m 4G -smp 2 -enable-kvm -hda output_rl9/rocky9.3 -netdev user,id=usernet0,hostfwd=tcp::3777-:22 -device virtio-net-pci,netdev=usernet0 -display none -vga none

# Try SSH connection until successful or until 1 minute has passed
echo "Try to connect vis ssh ..."
counter=0
until ssh -o StrictHostKeyChecking=no -i $1 -p 3777 rocky@localhost 'bash -s' < $2 > $3
do
  sleep 5
  counter=$((counter+1))
  if [ $counter -ge 12 ]; then
    echo "SSH connection failed after 1 minute. Exiting..."
    exit 1
  fi
  echo "Retrying SSH connection..."
done

# Kill the firecracker process to exit the workflow
echo "Stopping VM ..."
sleep 20
for i in $( ps ax | awk '/qemu-system-x86_64/ {print $1}' ); do kill -9 ${i}; done