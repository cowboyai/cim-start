# Using a Live Boot Image with NixOS-Anywhere
This allows a pretty simple way to achieve our installation if you have a network available.

1.  Download a live image
2.  copy it to usb
3.  boot
4.  sudo -i
5.  passwd <any password>
6.  ip addr (to obtain the dhcp addr, then update deploy.sh)
7.  if you don't have dhcp, give it a reachable addr
8.  ./test.sh
9.  fix any errors
10. ./deploy.sh
  