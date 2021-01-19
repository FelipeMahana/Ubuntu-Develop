#!/bin/bash

#links
# https://www.lifewire.com/pass-arguments-to-bash-script-2200571
# https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-20-04/
# https://linuxize.com/post/how-to-install-node-js-on-ubuntu-20-04/
# https://linuxhandbook.com/if-else-bash/
# https://gist.github.com/rachelhyman/b1f109155c9dafffe618
# https://gorails.com/setup/ubuntu/20.04#ruby-rvm


# SCRIPT INSTALACIÓN HERRAMIENTAS TRABAJO PARA UBUNTU 20.04
# es necesario tener instalado nvm

cd ~
sudo apt update -y

# Instalación nvm
#wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# agregar nvm a plugins
#sed -i 's/plugins=(git)/plugins=(git nvm)/g' ~/.zshrc

# Instalación de NodeJS y NPM con nvm

nvm install --lts

# Instalación de rbenv, Ruby, Ruby on Rails y PostgreSQL

#Yarn y dependencias, Node.js se instala anteriormente 
sudo apt install curl
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#dependencias
sudo apt install git-core zlib1g-dev build-essential libssl-dev libreadline-dev \
libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev \
software-properties-common libffi-dev yarn -y

#rbenv en bash y zsh (agregar if)
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#zsh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
exec $SHELL
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
#bash
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#zsh
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
exec $SHELL
#ruby
rbenv install 3.0.0
rbenv global 3.0.0
ruby -v
#bundler
gem install bundler
#
rbenv rehash
#rails
gem search '^rails$' --all
gem install rails -v 6.1.0
#PostgreSQL
sudo apt install postgresql postgresql-contrib libpq-dev -y
sudo -u postgres createuser felipe -s


# Instalacion de Nodemon con npm

npm install -g nodemon

# Instalacion de base de datos

#MongoDB
#https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

#importacion public key y dependencias
sudo apt install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
# crea archivo mongodb
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update -y
#instala los paquetes de mongodb
sudo apt install -y mongodb-org
#Inicio de MongoDb despues de un reiniciado
sudo systemctl enable mongod

# Elegir entre Atom o Visual Studio Code

editor=$1

if [ "$editor" = "vsc" ]; then
    echo "Eligio $editor."
	echo "Instalando Visual Studio Code."
    # Visual Studio Code
    #dependencias
    sudo apt install software-properties-common apt-transport-https build-essential -y
    # Instalación Visual Studio Code
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
elif [ "$editor" = "atom" ]; then
	echo "Eligio $editor."
    echo "Instalando Atom."
    # Atom
    wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt update && sudo apt install atom -y
    #paquetes atom
    apm install atom-beautify atom-ternjs emmet file-icons highlight-selected linter minimap pigments script minimap-git-diff minimap-highlight-selected
else
	echo "No se instalo ningun editor de texto."
fi

# Instalación Completada
cd ~
sudo apt update && sudo apt upgrade -y

echo $'\n'$"*** Todo Listo, Reiniciar Computador. ***"