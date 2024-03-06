#!/bin/bash
echo "Stopping vm"
for i in $( ps ax | awk '/qemu-system-x86_64/ {print $1}' ); do kill -9 ${i}; break; done