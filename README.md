
![](https://s3-ap-northeast-1.amazonaws.com/ms17222/step/Original_without_effects_204x75.png)

# SawaGem : auto generate code tools for sawa rest api

install it yourself as:

    $ gem install sawa

## Usage

create new crud project:

    $ sawa -n demo

create new crud project:

    $ cd demo
    
fill model.xls and it will create tables、resources、models、pages

![](https://s3-ap-northeast-1.amazonaws.com/ms17222/step/step1.JPG)

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

login(*before login must be regist, debug model password is 0000)

![](https://s3-ap-northeast-1.amazonaws.com/ms17222/step/step5.JPG)

after login

![](https://s3-ap-northeast-1.amazonaws.com/ms17222/step/step6.JPG)

## dependencies

    Ruby2.3
    JDK1.8
    Apache Ant
    npm
    
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

