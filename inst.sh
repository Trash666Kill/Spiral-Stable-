#!/bin/bash
#
#Non-free repo
cd /Spiral-main/Repository/
echo "**ADDING NON-FREE REPOSITORIES**"
rm -v /etc/apt/sources.list
cp -v sources.list /etc/apt/
#Update and Upgrade
echo "**UPDATING AND UPGRADING**"
apt update && apt upgrade -y
#Base packages*
echo "**INSTALLING BASE PACKAGES**"
echo "1"
apt install sudo cryptsetup smartmontools vim sshfs systemd-timesyncd xz-utils uuid pigz sshpass -y
echo "2"
apt install lm-sensors htop iotop stress hdparm x11-xkb-utils bc fwupd -y
echo "3"
apt install pm-utils acpid gcc make -y
echo "4"
apt install curl wget samba net-tools tcpdump traceroute nmap telnet iperf ethtool speedtest-cli nload autossh -y
echo "5"
apt install btrfs-progs -y
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
systemctl stop libvirtd
touch /etc/modprobe.d/kvm.conf
echo 'options kvm_intel nested=1' >> /etc/modprobe.d/kvm.conf
/sbin/modprobe -r kvm_intel
/sbin/modprobe kvm_intel
#Directories
echo "**CREATING DIRECTORIES**"
mkdir -pv /etc/scripts/interfaces
mkdir -v /etc/scripts/mount
mkdir -v /etc/scripts/tunnels
mkdir -v /etc/scripts/routes
mkdir -v /etc/scripts/others
mkdir -v /var/log/rc.local
chown emperor:emperor -R /var/log/rc.local
mkdir -v /mnt/Temp
mkdir -pv /mnt/Local/USB/A
mkdir -v /mnt/Local/USB/B
mkdir -v /mnt/Local/Container-A
mkdir -v /mnt/Local/Container-B
mkdir -v /mnt/Local/Essentials
mkdir -pv /mnt/Remote/Servers
chown emperor:emperor -R /mnt
mkdir -v /home/emperor/Temp
mkdir -v /home/emperor/.ssh
mkdir -v /root/.ssh
chown emperor:emperor -R /home/emperor
#Conf Base
echo "**SETTING UP BASE**"
systemctl disable smbd
cp -v zombie0.sh /etc/scripts/interfaces
chmod +x /etc/scripts/interfaces/zombie0.sh
cp -v cativeiro.sh /etc/scripts/tunnels
chmod +x /etc/scripts/tunnels/cativeiro.sh
cp -v enp1s0.sh /etc/scripts/routes
chmod +x /etc/scripts/routes/enp1s0.sh
cp -v rc.local /etc
chmod 755 /etc/rc.local
rm -v /etc/network/interfaces
cp -v interfaces /etc/network
rm -v /etc/samba/smb.conf
cp -v smb.conf /etc/samba
rm -v /etc/ssh/sshd_config
cp -v sshd_config /etc/ssh
rm -v /etc/motd
cp -v useful /home/emperor/.useful
touch /etc/motd
chmod 700 /home/emperor/.ssh
touch /home/emperor/.ssh/authorized_keys
chmod 600 /home/emperor/.ssh/authorized_keys
chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
/sbin/usermod -aG sudo emperor
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
rm -v /usr/share/desktop-base/grub_background.sh
rm -v /usr/share/images/desktop-base/desktop-grub.png
rm -v /etc/lightdm/lightdm-gtk-greeter.conf
tar -xvf Spiral.tar.xz -C /usr/share/wallpapers/ > /dev/null 2>&1
tar -xvf 01-Qogir.tar.xz -C /usr/share/icons > /dev/null 2>&1
tar -xvf Arc-Dark.tar.xz -C /usr/share/themes > /dev/null 2>&1
cp -v lightdm-gtk-greeter.conf /etc/lightdm/
cp -v explorer.desktop /usr/share/applications/
cp -v /usr/share/wallpapers/Spiral/desktop-grub.png /usr/share/images/desktop-base/
cp -v grub_background.sh /usr/share/desktop-base/
mkdir -pv /etc/X11/xorg.conf.d
# cp -v 40-libinput.conf /etc/X11/xorg.conf.d/
#Emperor
rm -rv /home/emperor/.config
tar -xvf home.tar.xz -C /home/emperor/ > /dev/null 2>&1
chown emperor:emperor -R /home/emperor/
chown emperor:emperor -R /usr/share/wallpapers/Spiral/
#systemctl set-default multi-user.target
systemctl disable x2goserver
update-grub

#Cleaning up
echo "**CLEANING UP**"
apt autoremove -y
rm -v /home/emperor/.bash_history
rm -v /root/.bash_history

#DUC
#echo "**Dynamic DNS Updater**"
#cp -v Repository/noip-duc-linux.tar.gz /usr/local/src
#cd /usr/local/src/
#tar xf noip-duc-linux.tar.gz
#cd noip-2.1.9-1/
#make install
#
#cp -v noip2.service /etc/systemd/system
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
su - emperor
#
fi
