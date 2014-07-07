echo "deb http://ftp.cixug.es/CRAN/bin/linux/debian wheezy-cran3/" >> /etc/apt/sources.list
apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480
apt-get update
apt-get install -y r-base r-base-dev


wget http://ftp.cixug.es/CRAN/src/contrib/tcltk2_1.2-10.tar.gz -O /tmp/tcltk2.tar.gz
R CMD INSTALL /tmp/tcltk2.tar.gz

wget http://ftp.cixug.es/CRAN/src/contrib/Rcmdr_2.0-4.tar.gz -O /tmp/rcmdr.tar.gz
R CMD INSTALL /tmp/rcmdr.tar.gz

wget -O- -q ftp://ftp.cixug.es/pub/Rprofile > /home/minino/.Rprofile
wget -O- -q ftp://ftp.cixug.es/pub/left > /home/minino/.config/lxpanel/LXDE/panels/lef
