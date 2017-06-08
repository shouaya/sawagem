# Sawa

install it yourself as:

    $ gem install sawa

## Usage

create new crud project:

    $ sawa -n demo

create new crud project:

    $ cd demo
    $ sawa -g model.xls
    $ ant compile

run api server (*before run api you must fix db config in mini.yml) 

    $ sawa -s
    
[http://localhost:9000/](http://localhost:9000)

run client

    $ cd www
    $ npm install
    $ npm start

[http://localhost:3000/](http://localhost:3000)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

