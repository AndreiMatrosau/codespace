#!/bin/bash
dnf -y update
dnf install -y epel-release
dnf install ansible -y