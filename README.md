# Moat Test

The project was develped using Ruby verion 3.1.3, Rails version 7.0.4.2 and mysql database

Tested on Linux Mint 21.1 and deployed to Heroku on: [Teste Moat](https://teste-moat.herokuapp.com/).

## How to run the project locally

### First, we need to install the dependencies:

We need to install ruby, to do so, I used rbenv. You can install using the commands below:

´´´
	
		$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	
		$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

	    $ exec $SHELL

	    $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

    	$echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

    	$ exec $SHELL

´´´

Then, to check if it was installed with no errors, run:

´´´

		rbenv version

´´´

### Install Ruby:

´´´

		rbenv install 3.1.3

		ruby -v

		rbenv global 3.1.3

		gem install bundler

		rbenv rehash

		gem install rails -v 7.0.4.2


´´´

Install the database:

´´´

		sudo apt-get install libmysqlclient-dev

		sudo mysql_secure_installation


´´´


### Install project dependencies and generate the database

´´´

	bundle install

    bundle exec rails db:crate
    
    bundle exec rails db:migrate

    bundle exec rails db:seed

´´´

### Run the server

´´´
	rails s
´´´

Now your server will be running under http://localhost:3000/
