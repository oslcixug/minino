#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Este script debe ser executado por root !!" 2>&1
  exit 1
fi

USUARIO="minino"

echo "Modificamos as pantallas de carga e de saída/apagado"

if [ ! -d /usr/share/plymouth/themes/joy-usc ]
then
	mkdir /usr/share/plymouth/themes/joy-usc
fi

# Descargamos o logotipo da USC
wget ftp://ftp.cixug.es/pub/USC/usc_logo.png -O /usr/local/share/icons/usc_logo.png

# Descargamos o tema para plymouth coa imaxe da USC

wget ftp://ftp.cixug.es/pub/USC/joy-usc/* -P /usr/share/plymouth/themes/joy-usc

plymouth-set-default-theme joy-usc
update-initramfs -u

# Modificamos a imaxe de fondo da xanela de inicio de sesión

wget ftp://ftp.cixug.es/pub/USC/usc-login.png -P /usr/local/share/pixmaps

sed -i -r -e 's/minino-login.jpg/usc-login.png/g' /etc/lightdm/lightdm-gtk-greeter.conf

# Pisar o ficheiro de configuración do texto e imaxe da xanela de apagado
cat <<EOF > /usr/local/bin/lxde-logout
#!/bin/sh
TXT="<span size='x-large'><i>Coa tecnoloxía de</i>
<b>MiniNo</b> <i>Ártabros</i></span>"
IMG="/usr/local/share/icons/usc_logo.png"
lxsession-logout --prompt "\$TXT" --banner "\$IMG" --side=top
EOF

cp /usr/local/share/icons/usc_logo.png /usr/local/share/icons/madexa.png

echo
echo "Modificadas as pantallas carga e de de saída/apagado"

echo
echo "Modificamos o fondo de pantalla polo da USC"

# Descargamos o fondo da USC
wget ftp://ftp.cixug.es/pub/USC/wallpaper-usc.png -P /usr/local/share/pixmaps/minino-wallpaper

# Modificamos o ficheiro «pcmanfm.conf»
sed -i -r -e 's/minino-wallpaper-2_1280x1024.jpg/wallpaper-usc.png/g' /home/$USUARIO/.config/pcmanfm/LXDE/pcmanfm.conf
sed -i -r -e 's/minino-wallpaper-2_1280x1024.jpg/wallpaper-usc.png/g' /etc/skel/.config/pcmanfm/LXDE/pcmanfm.conf
sed -i -r -e 's/minino-wallpaper-2_1280x1024.jpg/wallpaper-usc.png/g' /etc/xdg/pcmanfm/LXDE/pcmanfm.conf

echo
echo "Modificado o fondo de pantalla"

