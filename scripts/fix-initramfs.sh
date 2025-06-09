#!/bin/bash

latest_kernel=$(rpm -q --last kernel-core | head -n1 | awk '{print $1}' | cut -d'-' -f3-)
echo "Fixing initramfs for $latest_kernel"

sudo akmods --kernel "$latest_kernel"
sudo dracut --force "/boot/initramfs-${latest_kernel}.img" "$latest_kernel"
