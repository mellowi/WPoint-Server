WPoint
======
This is the server side backend for WPoint using Ruby, Sinatra and MongoDB.

### Authors

Anssi Syrjäsalo
Mikko Johansson


Prerequisites
=============
Install git
-----------
### Linux

    sudo apt-get install git-core

### Mac OS X

    brew install git


Getting up and running
======================
Install MongoDB
---------------
### Linux

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
    sudo sh -c "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list"
    sudo apt-get update
    sudo apt-get install mongodb-10gen

### Mac OS X

    brew install mongodb

To make MongoDB run on boot on OS X:

    mkdir -p ~/Library/LaunchAgents
    cp /usr/local/Cellar/mongodb/2.0.4-x86_64/homebrew.mxcl.mongodb.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist


Clone the repository
--------------------
    git clone git@github.com:mellowi/WPoint-Server.git


Install RVM and Ruby
--------------------
    bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    source ~/.rvm/scripts/rvm
    rvm pkg install readline
    rvm install 1.9.2-p290 --with-openssl-dir=/opt/local --with-readline-dir=$rvm_usr_path
    rvm rvmrc trust WPoint-Server/


Install gems
------------
    gem install bundler
    bundle install --without production


Generate some data to play with
-------------------------------
    rake test_data


Start your engines
------------------
    foreman start


Environments
============
### Development

    http://localhost:5000

### Production

    http://wpoint.herokuapp.com

Application is hosted in Heroku.
MongoDB is hosted in MongoHQ.


Rake
====
Console
-------

    rake

or

    rake console

Launches irb with all the requirements and initializes database connection.

Test data
---------

    rake test_data

Initializes database with random test reports.

Run tests
---------

    rake spec

Runs all the RSpec tests.

