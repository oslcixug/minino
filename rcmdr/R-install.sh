#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ser executado por root !!" 2>&1
   exit 1
fi

USUARIO="minino"

# Engadimos o repositorio CRAN da OSL

[[ ! -e /etc/apt/sources.list.d/cran.list ]] && {
	cat <<-EOF > /etc/apt/sources.list.d/cran.list
	deb http://ftp.cixug.es/CRAN/bin/linux/debian wheezy-cran3/
	EOF
}

# Descargamos e instalamos a chave para os servidores de CRAN
# En caso de non poder executarse debido a unha devasa, podemos
# descargalo desde ftp://ftp.cixug.es/pub/cran.gpg

apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

apt-get update

apt-get install -y --force-yes r-base r-base-dev

wget http://ftp.cixug.es/CRAN/src/contrib/tcltk2_1.2-10.tar.gz -O /tmp/tcltk2.tar.gz
R CMD INSTALL /tmp/tcltk2.tar.gz

wget http://ftp.cixug.es/CRAN/src/contrib/Rcmdr_2.0-4.tar.gz -O /tmp/rcmdr.tar.gz
R CMD INSTALL /tmp/rcmdr.tar.gz

# Engadimos o script a executar no inicio de R
# na configuración do USUARIO como no esqueleto de novos usuarios

wget -O- -q ftp://ftp.cixug.es/pub/Rprofile > /tmp/Rprofile
cp /tmp/Rprofile  /home/$USUARIO/.Rprofile
cp /tmp/Rprofile  /etc/skel/.Rprofile

# Descargamos o ficheiro coa nova configuración do panel esquerdo coa icona para abrir R
# copiamos o ficheiro dentro da configuración do USUARIO e do esqueleto para novos usuarios

wget -O- -q ftp://ftp.cixug.es/pub/left > /tmp/left

cp /tmp/left /home/$USUARIO/.config/lxpanel/LXDE/panels/left
cp /tmp/left /home/$USUARIO/.config/lxpanel/GNOME2/panels/left

cp /tmp/left /etc/skel/.config/lxpanel/LXDE/panels/left
cp /tmp/left /etc/skel/.config/lxpanel/GNOME2/panels/left
