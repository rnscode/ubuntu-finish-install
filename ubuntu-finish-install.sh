#!/usr/bin/env sh

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt install -y git curl wget zip unzip vim tilix

sudo apt install -y network-manager libnss3-tools jq xsel
sudo apt install -y php-cli php-fpm php-curl php-pdo php-mysql php-sqlite3 php-gd php-xml php-mcrypt php-mbstring php-iconv php-bcmath php-ctype php-json php-tokenizer php-zip

EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
COMPOSER_INSTALLED="0"

if [ "$EXPECTED_CHECKSUM" -eq "$ACTUAL_CHECKSUM" ]
then
    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
    COMPOSER_INSTALLED="1"
else 
    echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
fi

if [$COMPOSER_INSTALLED -eq "1"]
then
    #if composer installed
fi