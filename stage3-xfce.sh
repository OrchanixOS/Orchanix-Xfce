#!/bin/bash
#
# OrchanixOS Stage 3 build script (Xfce).
# Copyright (C) 2022 OrchanixOS Developers.
#
# Exit on error.
set -e
# Change to the sources directory.
cd /sources
# Set up basic environment variables, same as Stage 2.
. build.env
# === IF RESUMING A FAILED BUILD, ONLY REMOVE LINES BELOW THIS ONE.
# Install Rust to a temporary directory to support building some packages.
tar -xf rust-1.64.0-x86_64-unknown-linux-gnu.tar.gz
cd rust-1.64.0-x86_64-unknown-linux-gnu
./install.sh --prefix=/sources/rust --without=rust-docs
cd ..
rm -rf rust-1.64.0-x86_64-unknown-linux-gnu
# Arc Theme for Xfce.
tar --no-same-owner -xf arc-theme-20220102.tar.xz -C /usr/share --strip-components=1
gtk-update-icon-cache /usr/share/icons/Arc
mkdir -p /etc/gtk-2.0
cat > /etc/gtk-2.0/gtkrc << "END"
gtk-theme-name = "Arc-Dark"
gtk-icon-theme-name = "Arc"
gtk-cursor-theme-name = "Adwaita"
gtk-font-name = "Noto Sans 10"
END
mkdir -p /etc/gtk-3.0
cat > /etc/gtk-3.0/settings.ini << "END"
[Settings]
gtk-theme-name = Arc-Dark
gtk-icon-theme-name = Arc
gtk-font-name = Noto Sans 10
gtk-cursor-theme-size = 0
gtk-toolbar-style = GTK_TOOLBAR_ICONS
gtk-xft-antialias = 1
gtk-xft-hinting = 1
gtk-xft-hintstyle = hintnone
gtk-xft-rgba = rgb
gtk-cursor-theme-name = Adwaita
END
flatpak install -y runtime/org.gtk.Gtk3theme.Arc{,-Dark}/x86_64/3.22
# libxfce4util.
tar -xf libxfce4util-4.17.2.tar.bz2
cd libxfce4util-4.17.2
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/libxfce4util -Dm644 COPYING
cd ..
rm -rf libxfce4util-4.17.2
# xfconf.
tar -xf xfconf-4.16.0.tar.bz2
cd xfconf-4.16.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/xfconf -Dm644 COPYING
cd ..
rm -rf xfconf-4.16.0
# libxfce4ui.
tar -xf libxfce4ui-4.17.6.tar.bz2
cd libxfce4ui-4.17.6
./configure --prefix=/usr --sysconfdir=/etc --with-vendor-info=OrchanixOS
make
make install
install -t /usr/share/licenses/libxfce4ui -Dm644 COPYING
cd ..
rm -rf libxfce4ui-4.17.6
# Exo.
tar -xf exo-4.17.2.tar.bz2
cd exo-4.17.2
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/exo -Dm644 COPYING
cd ..
rm -rf exo-4.17.2
# Garcon.
tar -xf garcon-4.17.1.tar.bz2
cd garcon-4.17.1
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/garcon -Dm644 COPYING
cd ..
rm -rf garcon-4.17.1
# Thunar.
tar -xf thunar-4.17.9.tar.bz2
cd thunar-4.17.9
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/thunar -Dm644 COPYING
cd ..
rm -rf thunar-4.17.9
# thunar-volman.
tar -xf thunar-volman-4.16.0.tar.bz2
cd thunar-volman-4.16.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/thunar-volman -Dm644 COPYING
cd ..
rm -rf thunar-volman-4.16.0
# Tumbler.
tar -xf tumbler-4.17.2.tar.bz2
cd tumbler-4.17.2
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/tumbler -Dm644 COPYING
cd ..
rm -rf tumbler-4.17.2
# xfce4-appfinder.
tar -xf xfce4-appfinder-4.17.0.tar.bz2
cd xfce4-appfinder-4.17.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/xfce4-appfinder -Dm644 COPYING
cd ..
rm -rf xfce4-appfinder-4.17.0
# xfce4-panel.
tar -xf xfce4-panel-4.17.3.tar.bz2
cd xfce4-panel-4.17.3
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/xfce4-panel -Dm644 COPYING
cd ..
rm -rf xfce4-panel-4.17.3
# xfce4-power-manager.
tar -xf xfce4-power-manager-4.16.0.tar.bz2
cd xfce4-power-manager-4.16.0
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/xfce4-power-manager -Dm644 COPYING
cd ..
rm -rf xfce4-power-manager-4.16.0
# xfce4-settings.
tar -xf xfce4-settings-4.16.3.tar.bz2
cd xfce4-settings-4.16.3
./configure --prefix=/usr --sysconfdir=/etc --enable-sound-settings
make
make install
install -t /usr/share/licenses/xfce4-settings -Dm644 COPYING
cd ..
rm -rf xfce4-settings-4.16.3
# xfdesktop.
tar -xf xfdesktop-4.17.0.tar.bz2
cd xfdesktop-4.17.0
./configure --prefix=/usr
make
make install
mv /usr/share/backgrounds/xfce/xfce-verticals{,1}.png
install -t /usr/share/licenses/xfdesktop -Dm644 COPYING
cd ..
rm -rf xfdesktop-4.17.0
# xfwm4.
tar -xf xfwm4-4.16.1.tar.bz2
cd xfwm4-4.16.1
./configure --prefix=/usr
make
make install
sed -i 's/Default/Arc-Dark/' /usr/share/xfwm4/defaults
install -t /usr/share/licenses/xfwm4 -Dm644 COPYING
cd ..
rm -rf xfwm4-4.16.1
# xfce4-session.
tar -xf xfce4-session-4.16.0.tar.bz2
cd xfce4-session-4.16.0
./configure --prefix=/usr --sysconfdir=/etc --disable-legacy-sm
make
make install
update-desktop-database
update-mime-database /usr/share/mime
install -t /usr/share/licenses/xfce4-session -Dm644 COPYING
cd ..
rm -rf xfce4-session-4.16.0
# Parole.
tar -xf parole-4.16.0.tar.bz2
cd parole-4.16.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/parole -Dm644 COPYING
cd ..
rm -rf parole-4.16.0
# Orage.
tar -xf orage-4.16.0.tar.bz2
cd orage-4.16.0
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib/xfce4 --disable-debug --disable-static
make
make install
install -t /usr/share/licenses/orage -Dm644 COPYING
cd ..
rm -rf orage-4.16.0
# Xfburn.
tar -xf xfburn-0.6.2.tar.bz2
cd xfburn-0.6.2
./configure --prefix=/usr --enable-gstreamer --disable-debug --disable-static
make
make install
install -t /usr/share/licenses/xfburn -Dm644 COPYING
cd ..
rm -rf xfburn-0.6.2
# xfce4-terminal.
tar -xf xfce4-terminal-1.0.4.tar.bz2
cd xfce4-terminal-1.0.4
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/xfce4-terminal -Dm644 COPYING
cd ..
rm -rf xfce4-terminal-1.0.4
# Shotwell.
tar -xf shotwell-shotwell-0.31.5.tar.bz2
cd shotwell-shotwell-0.31.5
mkdir SHOTWELL-build; cd SHOTWELL-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/shotwell -Dm644 ../COPYING
cd ../..
rm -rf shotwell-shotwell-0.31.5
# xfce4-notifyd.
tar -xf xfce4-notifyd-0.6.4.tar.bz2
cd xfce4-notifyd-0.6.4
./configure --prefix=/usr --sysconfdir=/etc
make
make install
install -t /usr/share/licenses/xfce4-notifyd -Dm644 COPYING
cd ..
rm -rf xfce4-notifyd-0.6.4
# xfce4-pulseaudio-plugin.
tar -xf xfce4-pulseaudio-plugin-0.4.5.tar.bz2
cd xfce4-pulseaudio-plugin-0.4.5
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/xfce4-pulseaudio-plugin -Dm644 COPYING
cd ..
rm -rf xfce4-pulseaudio-plugin-0.4.5
# pavucontrol.
tar -xf pavucontrol-5.0.tar.xz
cd pavucontrol-5.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/pavucontrol -Dm644 LICENSE
cd ..
rm -rf pavucontrol-5.0
# Blueman.
tar -xf blueman-2.2.2.tar.xz
cd blueman-2.2.2
sed -i '/^dbusdir =/ s/sysconfdir/datadir/' data/configs/Makefile.{am,in}
./configure --prefix=/usr --sysconfdir=/etc --with-dhcp-config=/etc/dhcp/dhcpd.conf
make
make install
mv /etc/xdg/autostart/blueman.desktop /usr/share/blueman/autostart.desktop
cat > /usr/sbin/blueman-autostart << "END"
#!/bin/bash

not_root() {
  echo "Error: $(basename "$0") must be run as root." >&2
  exit 1
}

usage() {
  echo "$(basename "$0"): Control whether Blueman will autostart on login."
  echo "Usage: $(basename "$0") [enable|disable]" >&2
  exit 1
}

[ $EUID -eq 0 ] || not_root

[ ! -z "$1" ] || usage

case "$1" in
  enable) cp -af /usr/share/blueman/autostart.desktop /etc/xdg/autostart/blueman.desktop ;;
  disable) rm -f /etc/xdg/autostart/blueman.desktop ;;
  *) usage ;;
esac
END
chmod 755 /sbin/blueman-autostart
install -t /usr/share/licenses/blueman -Dm644 COPYING
cd ..
rm -rf blueman-2.2.2
# xfce4-screenshooter.
tar -xf xfce4-screenshooter-1.9.11.tar.bz2
cd xfce4-screenshooter-1.9.11
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static --disable-debug
make
make install
install -t /usr/share/licenses/xfce4-screenshooter -Dm644 COPYING
cd ..
rm -rf xfce4-screenshooter-1.9.11
# xfce4-taskmanager.
tar -xf xfce4-taskmanager-1.5.4.tar.bz2
cd xfce4-taskmanager-1.5.4
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-debug
make
make install
install -t /usr/share/licenses/xfce4-taskmanager -Dm644 COPYING
cd ..
rm -rf xfce4-taskmanager-1.5.4
# xfce4-clipman-plugin.
tar -xf xfce4-clipman-plugin-1.6.2.tar.bz2
cd xfce4-clipman-plugin-1.6.2
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static --disable-debug
make
make install
install -t /usr/share/licenses/xfce4-clipman-plugin -Dm644 COPYING
cd ..
rm -rf xfce4-clipman-plugin-1.6.2
# xfce4-mount-plugin.
tar -xf xfce4-mount-plugin-1.1.5.tar.bz2
cd xfce4-mount-plugin-1.1.5
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static --disable-debug
make
make install
install -t /usr/share/licenses/xfce4-mount-plugin -Dm644 COPYING
cd ..
rm -rf xfce4-mount-plugin-1.1.5
# xfce4-whiskermenu-plugin.
tar -xf xfce4-whiskermenu-plugin-2.6.1.tar.bz2
cd xfce4-whiskermenu-plugin-2.6.1
mkdir whisker-build; cd whisker-build
cmake -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -Wno-dev -G Ninja ..
ninja
ninja install
install -t /usr/share/licenses/xfce4-whiskermenu-plugin -Dm644 ../COPYING
cd ../..
rm -rf xfce4-whiskermenu-plugin-2.6.1
# xfce4-screensaver.
tar -xf xfce4-screensaver-4.16.0.tar.bz2
cd xfce4-screensaver-4.16.0
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static --disable-debug
make
make install
install -t /usr/share/licenses/xfce4-screensaver -Dm644 COPYING
cd ..
rm -rf xfce4-screensaver-4.16.0
# xarchiver.
tar -xf xarchiver-0.5.4.19.tar.gz
cd xarchiver-0.5.4.19
./configure  --prefix=/usr --libexecdir=/usr/lib/xfce4
make
make install
install -t /usr/share/licenses/xarchiver -Dm644 COPYING
gtk-update-icon-cache -qtf /usr/share/icons/hicolor
update-desktop-database -q
cd ..
rm -rf xarchiver-0.5.4.19
# thunar-archive-plugin.
tar -xf thunar-archive-plugin-0.5.0.tar.bz2
cd thunar-archive-plugin-0.5.0
./configure --prefix=/usr --sysconfdir=/etc  --libexecdir=/usr/lib/xfce4 --localstatedir=/var --disable-static
make
make install
install -t /usr/share/licenses/thunar-archive-plugin -Dm644 COPYING
cd ..
rm -rf thunar-archive-plugin-0.5.0
# gtksourceview4.
tar -xf gtksourceview-4.8.3.tar.xz
cd gtksourceview-4.8.3
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gtksourceview4 -Dm644 ../COPYING
cd ../..
rm -rf gtksourceview-4.8.3
# Mousepad.
tar -xf mousepad-0.5.10.tar.bz2
cd mousepad-0.5.10
./configure --prefix=/usr --enable-gtksourceview4 --enable-keyfile-settings
make
make install
install -t /usr/share/licenses/mousepad -Dm644 COPYING
cd ..
rm -rf mousepad-0.5.10
# galculator.
tar -xf galculator-2.1.4.tar.gz
cd galculator-2.1.4
sed -i 's/s_preferences/extern s_preferences/' src/main.c
autoreconf -fi
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/galculator -Dm644 COPYING
cd ..
rm -rf galculator-2.1.4
# GParted.
tar -xf gparted-GPARTED_1_4_0.tar.bz2
cd gparted-GPARTED_1_4_0
autoreconf -fi
./configure --prefix=/usr --disable-doc --disable-static --enable-libparted-dmraid --enable-online-resize --enable-xhost-root
make
make install
install -t /usr/share/licenses/gparted -Dm644 COPYING
cd ..
rm -rf gparted-GPARTED_1_4_0
# Popsicle.
tar -xf popsicle-1.3.0-65-g389d13d.tar.xz
cd popsicle-1.3.0-65-g389d13d
RUSTFLAGS="-C relocation-model=dynamic-no-pic" make prefix=/usr install
install -t /usr/share/licenses/popsicle -Dm644 LICENSE
cd ..
rm -rf popsicle-1.3.0-65-g389d13d
# Mugshot.
tar -xf mugshot-0.4.3.tar.gz
cd mugshot-0.4.3
python setup.py install --optimize=1
glib-compile-schemas /usr/share/glib-2.0/schemas
install -t /usr/share/licenses/mugshot -Dm644 COPYING
cd ..
rm -rf mugshot-0.4.3
# libetpan (for Claws Mail).
tar -xf libetpan-1.9.4.tar.gz
cd libetpan-1.9.4
patch -Np1 -i ../patches/libetpan-1.9.4-securityfix.patch
./autogen.sh --prefix=/usr --disable-debug --disable-static --with-gnutls --without-openssl
make
make install
install -t /usr/share/licenses/libetpan -Dm644 COPYRIGHT
cd ..
rm -rf libetpan-1.9.4
# Claws Mail.
tar -xf claws-mail-4.1.0.tar.xz
cd claws-mail-4.1.0
patch -Np1 -i ../patches/claws-mail-4.1.0-perl5.36.patch
./configure --prefix=/usr --disable-static --enable-bogofilter-plugin --enable-crash-dialog --enable-enchant --enable-gnutls --enable-ldap --enable-manual --enable-pgpmime-plugin --enable-spamassassin-plugin
make
make install
install -t /usr/share/licenses/claws-mail -Dm644 COPYING
cd ..
rm -rf claws-mail-4.1.0
# Evince.
tar -xf evince-43.0.tar.xz
cd evince-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dnautilus=false ..
ninja
ninja install
install -t /usr/share/licenses/evince -Dm644 ../COPYING
cd ../..
rm -rf evince-43.0
# Baobab.
tar -xf baobab-41.0.tar.xz
cd baobab-41.0
mkdir baobab-build; cd baobab-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/baobab -Dm644 ../COPYING ../COPYING.docs
cd ../..
rm -rf baobab-41.0
# gnome-firmware.
tar -xf gnome-firmware-41.0.tar.bz2
cd gnome-firmware-41.0
mkdir gnome-firmware-build; cd gnome-firmware-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-firmware -Dm644 ../COPYING
cd ../..
rm -rf gnome-firmware-41.0
# GNOME Software.
tar -xf gnome-software-41.5.tar.xz
cd gnome-software-41.5
mkdir gnome-software-build; cd gnome-software-build
meson --prefix=/usr --buildtype=minsize -Dpackagekit=false -Dtests=false -Dvalgrind=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-software -Dm644 ../COPYING
cd ../..
rm -rf gnome-software-41.5
# FreeRDP.
tar -xf freerdp-2.8.0.tar.gz
cd freerdp-2.8.0
mkdir FreeRDP-build; cd FreeRDP-build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_SKIP_RPATH=ON -DPROXY_PLUGINDIR=/usr/lib/freerdp2/server/proxy/plugins -DCHANNEL_URBDRC_CLIENT=ON -DWITH_CHANNELS=ON -DWITH_CLIENT_CHANNELS=ON -DWITH_CUPS=ON -DWITH_DSP_FFMPEG=ON -DWITH_FAAD2=ON -DWITH_FFMPEG=ON -DWITH_GSSAPI=ON -DWITH_ICU=ON -DWITH_JPEG=ON -DWITH_LAME=ON -DWITH_OPENH264=ON -DWITH_PKCS11=ON -DWITH_PULSE=ON -DWITH_SERVER=ON -DWITH_SERVER_CHANNELS=ON -DWITH_SWSCALE=ON -Wno-dev -G Ninja ..
ninja
ninja install
install -t /usr/share/licenses/freerdp -Dm644 ../LICENSE
cd ../..
rm -rf freerdp-2.8.0
# Weston.
tar -xf weston-10.0.2.tar.bz2
cd weston-10.0.2
mkdir weston-build; cd weston-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/weston -Dm644 ../COPYING
cd ../..
rm -rf weston-10.0.2
# LightDM.
tar -xf lightdm-1.32.0.tar.xz
cd lightdm-1.32.0
groupadd -g 65 lightdm
useradd -c "Lightdm Daemon" -d /var/lib/lightdm -u 65 -g lightdm -s /sbin/nologin lightdm
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib/lightdm --sbindir=/usr/bin --disable-static --disable-tests --with-greeter-user=lightdm --with-greeter-session=lightdm-gtk-greeter
make
make install
cp tests/src/lightdm-session /usr/bin
sed -i '1 s/sh/bash --login/' /usr/bin/lightdm-session
sed -i 's/#user-session=default/user-session=xfce/' /etc/lightdm/lightdm.conf
rm -rf /etc/init
install -dm755 -o lightdm -g lightdm /var/lib/lightdm
install -dm755 -o lightdm -g lightdm /var/lib/lightdm-data
install -dm755 -o lightdm -g lightdm /var/cache/lightdm
install -dm770 -o lightdm -g lightdm /var/log/lightdm
install -t /usr/share/licenses/lightdm -Dm644 COPYING.GPL3 COPYING.LGPL2 COPYING.LGPL3
cd ..
rm -rf lightdm-1.32.0
# lightdm-gtk-greeter.
tar -xf lightdm-gtk-greeter-2.0.8.tar.gz
cd lightdm-gtk-greeter-2.0.8
./configure --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/lib/lightdm --sbindir=/usr/bin --disable-libido --disable-libindicator --disable-maintainer-mode --disable-static --enable-kill-on-sigterm --with-libxklavier
make
make install
sed -i 's/#background=/background = \/usr\/share\/backgrounds\/xfce\/Orchanix-Gray-Middle.png/' /etc/lightdm/lightdm-gtk-greeter.conf
install -t /usr/share/licenses/lightdm-gtk-greeter -Dm644 COPYING
systemctl enable lightdm
cd ..
rm -rf lightdm-gtk-greeter-2.0.8
# Firefox.
tar --no-same-owner -xf firefox-105.0.1.tar.bz2 -C /usr/lib
mkdir -p /usr/lib/firefox/distribution
cat > /usr/lib/firefox/distribution/policies.json << END
{
  "policies": {
    "DisableAppUpdate": true
  }
}
END
ln -sr /usr/lib/firefox/firefox /usr/bin/firefox
mkdir -p /usr/share/{applications,pixmaps}
cat > /usr/share/applications/firefox.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
END
ln -sr /usr/lib/firefox/browser/chrome/icons/default/default128.png /usr/share/pixmaps/firefox.png
install -dm755 /usr/share/licenses/firefox
cat > /usr/share/licenses/firefox/LICENSE << "END"
Please type 'about:license' in the Firefox URL box to view the Firefox license.
END
