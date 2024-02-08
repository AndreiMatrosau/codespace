scripts = ["install_ansible.sh"]
inline  = ["dnf -y update", "dnf install -y epel-release", "dnf install ansible -y"]