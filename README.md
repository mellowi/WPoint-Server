Getting up and running
======================

Install git (if not already installed)
--------------------------------------
**Linux**

    sudo apt-get install git-core

**Mac OS X**

    brew install git


Install MongoDB
---------------
**Linux**

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
    sudo sh -c "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list"
    sudo apt-get update
    sudo apt-get install mongodb-10gen

**Mac OS X**

    brew install mongodb
    <follow given instructions to make it run on boot>


Clone the repository
--------------------
    git clone git@github.com:mellowi/WPoint-Server.git


Install RVM and Ruby
--------------------
    bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
    echo "[[ -s "/.rvm/scripts/rvm" ]] && source "/.rvm/scripts/rvm"" >> ~/.bashrc
    source ~/.bashrc
    rvm pkg install readline
    rvm install 1.9.2-p290 --with-openssl-dir=/opt/local --with-readline-dir=$rvm_usr_path
    rvm rvmrc trust WPoint-Server/


Install gems
------------
    gem install bundler
    bundle install


Generate some data to play with
-------------------------------
    rake test_data


Start your engines
------------------
    foreman start


URLS
====
**Development**

    http://localhost:5000

**Production**

    http://wpoint.herokuapp.com
