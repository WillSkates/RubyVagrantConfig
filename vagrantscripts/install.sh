#!/bin/bash

if [ ! -f /etc/will/DELETETOREINSTALL ]; then

	sudo apt-get -q -y --force-yes install python-software-properties
	sudo apt-get -q -y --force-yes install software-properties-common

	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password pass'
	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password pass'

	sudo apt-get -y --force-yes install mysql-server-5.5

	sudo mysql --user=root --password=pass -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'pass';"

	sudo cp /vagrant/vagrantscripts/my.cnf /etc/mysql/my.cnf

	service mysql restart

	sudo apt-get -y --force-yes install build-essential openssl libreadline6 libreadline6-dev
	sudo apt-get -y --force-yes install curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3
	sudo apt-get -y --force-yes install libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison
	sudo apt-get -y --force-yes install subversion pkg-config

	curl -L https://get.rvm.io | bash -s stable --ruby

	source /usr/local/rvm/scripts/rvm
	echo "source /usr/local/rvm/scripts/rvm" >> ~/.bash_profile


	gem install rails -v 4.0.0
	gem install rake
	gem install bundler
	gem install execjs
	gem install therubyracer
	
	sudo mkdir /etc/will
	sudo cat > /etc/will/DELETETOREINSTALL

fi