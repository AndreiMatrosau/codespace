#!/bin/bash
echo "Ensure core dump storage is disabled"
grep -i '^\s*storage\s*=\s*none' /etc/systemd/coredump.conf
echo "Ensure core dump backtraces are disabled"
grep -Pi '^\h*ProcessSizeMax\h*=\h*0\b' /etc/systemd/coredump.conf || echo -e "\n- Audit results:\n ** Fail **\n - \"ProcessSizeMax\" is: \"$(grep -i 'ProcessSizeMax' /etc/systemd/coredump.conf)\""
echo "Ensure SELinux is installed"
rpm -q libselinux
echo "Ensure SELinux policy is configured"
grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config
echo "Ensure permissions on /etc/ssh/sshd_config are configured"
stat -Lc "%n %a %u/%U %g/%G" /etc/ssh/sshd_config
echo "Exit"
