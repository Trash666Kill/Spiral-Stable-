#!/bin/bash
#
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as sudo"
   	exit 1
else
#Non-free repo
cd /Spiral/Repository/
echo "**ADDING NON-FREE REPOSITORIES**"
rm /etc/apt/sources.list
cp sources.list /etc/apt/
#Update and Upgrade
echo "**UPDATING AND UPGRADING**"
apt update && apt upgrade -y
#Base packages*
echo "**INSTALLING BASE PACKAGES**"
echo "1"
apt install sudo cryptsetup smartmontools vim sshfs xz-utils uuid pigz -y
echo "2"
apt install lm-sensors htop iotop stress hdparm x11-xkb-utils -y
echo "3"
apt install pm-utils acpid gcc make -y
echo "4"
apt install curl wget samba net-tools nmap telnet iperf ethtool speedtest-cli nload netdata -y
echo "5"
apt install f2fs-tools btrfs-progs -y
#echo "6"
#apt install nvidia-driver firmware-amd-graphics -y
echo "7"
apt install firmware-misc-nonfree firmware-realtek firmware-atheros -y
#echo "8"
#apt install broadcom-sta-dkms -y
#dpkg -i broadcom-bt-firmware-10.1.0.1115.deb
#apt install -f -y
#Hypervisor
echo "**INSTALLING HYPERVISOR**"
apt install qemu-kvm libvirt0 bridge-utils libvirt-daemon-system -y
gpasswd libvirt -a emperor
systemctl disable libvirtd
#Directories
echo "**CREATING DIRECTORIES**"
mkdir -p /etc/scripts/interfaces
mkdir /etc/scripts/mount
mkdir /mnt/Temp
mkdir -p /mnt/Local/USB/A
mkdir /mnt/Local/USB/B
mkdir /mnt/Local/Container-A
mkdir /mnt/Local/Container-B
mkdir -p /mnt/Remote/Servers
chown emperor:emperor -R /mnt
mkdir /home/emperor/Temp
mkdir /home/emperor/.ssh
mkdir /root/.ssh
#Conf Base
echo "**SETTING UP BASE**"
systemctl disable smbd
systemctl disable netdata
cp zombie0.sh /etc/scripts/interfaces
chmod +x /etc/scripts/interfaces/zombie0.sh
cp rc.local /etc
chmod 755 /etc/rc.local
rm /etc/network/interfaces
cp interfaces /etc/network
rm /etc/samba/smb.conf
cp smb.conf /etc/samba
rm /etc/ssh/sshd_config
cp sshd_config /etc/ssh
rm /etc/motd
touch /etc/motd
chmod 700 /home/emperor/.ssh
touch /home/emperor/.ssh/authorized_keys
chmod 600 /home/emperor/.ssh/authorized_keys
chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
#DE
echo "**INSTALLING THE DESKTOP ENVIRONMENT**"
echo "1"
apt install xorg xserver-xorg-input-libinput xserver-xorg-input-evdev -y
echo "2"
apt install xserver-xorg-input-mouse xserver-xorg-input-synaptics -y
echo "3"
apt install lightdm openbox obconf lxterminal lxpanel xscreensaver lxhotkey-gtk -y
echo "4"
apt install lxtask lxsession-logout lxappearance lxrandr xfce4-power-manager progress -y
echo "5"
apt install arc-theme nitrogen x2goserver ffmpegthumbnailer -y
echo "6"
apt install gpicview evince galculator gnome-screenshot pluma alacarte -y
echo "7"
apt install connman connman-ui connman-gtk compton caja qshutdown unrar -y
echo "8"
apt install firefox-esr caffeine engrampa gparted gnome-disk-utility baobab -y
echo "9"
apt install virt-manager ssh-askpass -y
#Conf DE
echo "**SETTING UP THE DESKTOP ENVIRONMENT**"
rm /usr/share/desktop-base/grub_background.sh
rm /usr/share/images/desktop-base/desktop-grub.png
rm /etc/lightdm/lightdm-gtk-greeter.conf
tar -xvf Spiral.tar.xz -C /usr/share/wallpapers/ > /dev/null 2>&1
tar -xvf 01-Qogir.tar.xz -C /usr/share/icons > /dev/null 2>&1
tar -xvf Arc-Dark.tar.xz -C /usr/share/themes > /dev/null 2>&1
cp lightdm-gtk-greeter.conf /etc/lightdm/
cp explorer.desktop /usr/share/applications/
cp /usr/share/wallpapers/Spiral/desktop-grub.png /usr/share/images/desktop-base/
cp grub_background.sh /usr/share/desktop-base/
mkdir -p /etc/X11/xorg.conf.d
# cp 40-libinput.conf /etc/X11/xorg.conf.d/
#Emperor
rm -r /home/emperor/.config
tar -xvf home.tar.xz -C /home/emperor/ > /dev/null 2>&1
chown emperor:emperor -R /home/emperor/
chown emperor:emperor -R /usr/share/wallpapers/Spiral/
#systemctl set-default multi-user.target
systemctl disable x2goserver
update-grub

#Cleaning up
echo "**CLEANING UP**"
apt autoremove -y
rm /home/emperor/.bash_history
rm /root/.bash_history

#DUC
#echo "**Dynamic DNS Updater**"
#cp Repository/noip-duc-linux.tar.gz /usr/local/src
#cd /usr/local/src/
#tar xf noip-duc-linux.tar.gz
#cd noip-2.1.9-1/
#make install
#
#cp noip2.service /etc/systemd/system
#systemctl daemon-reload
#systemctl enable noip2
#systemctl disable noip2
#systemctl start noip2
#systemctl status noip2
#cd /Spiral

#End
echo "End"
#Manual settings
echo "1 - Manually configure samba users and their respective passwords
2 - Add the host IP address to netdata at /etc/netdata/netdata.conf
3 - Adjust network nics according to the environment
4 - Activate the modules according to your environment"
#
fi
