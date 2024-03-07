#!/bin/bash
# run-vm.sh

# Parse arguments
while getopts k:s:o:i:u: flag
do
    case "${flag}" in
        k) key=${OPTARG};;
        s) script=${OPTARG};;
        o) output=${OPTARG};;
        i) image=${OPTARG};;
        u) user=${OPTARG};;
    esac
done

echo "Starting VM ..."
if ! sudo qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -boot c -drive format=raw,id=drive1,if=none,file=$image -cpu host -m 4G -smp 2 -enable-kvm -hda $image -netdev user,id=usernet0,hostfwd=tcp::3777-:22 -device virtio-net-pci,netdev=usernet0 -display none -vga none &; then
    echo "Failed to start VM. Exiting..."
    exit 1
fi

# Try SSH connection until successful or until 1 minute has passed
echo "Try to connect via ssh ..."
counter=0
until ssh -o StrictHostKeyChecking=no -i $key -p 3777 $user@localhost 'bash -s' < $script > $output
do
  sleep 5
  counter=$((counter+1))
  if [ $counter -ge 12 ]; then
    echo "SSH connection failed after 1 minute. Exiting..."
    exit 1
  fi
  echo "Retrying SSH connection..."
done