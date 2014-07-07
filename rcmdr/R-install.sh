USUARIO="minino"

# echo "deb http://ftp.cixug.es/CRAN/bin/linux/debian wheezy-cran3/" >> /etc/apt/sources.list

[[ ! -e /etc/apt/sources.list.d/cran.list ]] && {
	cat <<-EOF > /etc/apt/sources.list.d/cran.list
	deb http://ftp.cixug.es/CRAN/bin/linux/debian wheezy-cran3/
	EOF
}

apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

apt-get update

apt-get install -y --force-yes r-base r-base-dev

wget http://ftp.cixug.es/CRAN/src/contrib/tcltk2_1.2-10.tar.gz -O /tmp/tcltk2.tar.gz
R CMD INSTALL /tmp/tcltk2.tar.gz

wget http://ftp.cixug.es/CRAN/src/contrib/Rcmdr_2.0-4.tar.gz -O /tmp/rcmdr.tar.gz
R CMD INSTALL /tmp/rcmdr.tar.gz

## Instalación dependencias do paquete «r»
## dpkg -I nome_paquete_R.deb > depends.txt

LISTA="paquete1 paquete2 paquete3 ... paqueteN"
apt-get install -y --force-yes $LISTA

## Instaladas as dependencias, instalamos o paquete principal
dpkg -i paquete.deb


wget -O- -q ftp://ftp.cixug.es/pub/Rprofile > /tmp/Rprofile
cp /tmp/Rprofile  /home/$USUARIO/.Rprofile
cp /tmp/Rprofile  /etc/skel/.Rprofile

#wget -O- -q ftp://ftp.cixug.es/pub/left > /home/$USUARIO/.config/lxpanel/LXDE/panels/left
wget -O- -q ftp://ftp.cixug.es/pub/left > /tmp/left

cp /tmp/left /home/$USUARIO/.config/lxpanel/LXDE/panels/left
cp /tmp/left /home/$USUARIO/.config/lxpanel/GNOME2/panels/left
cp /tmp/left /etc/skel/.config/lxpanel/LXDE/panels/left
cp /tmp/left /etc/skel/.config/lxpanel/GNOME2/panels/left
