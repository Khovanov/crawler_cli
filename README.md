# README
Simple cli crawler example with concurrency:
it accept links and return messages with page titles

## Applied gems
(Nokogiri)[https://github.com/sparklemotion/nokogiri]

(HTTParty)[https://github.com/jnunemaker/httparty]

## Test framework
(RSpec)[https://rspec.info/]

## Thread
(Ruby doc: Thread)[https://ruby-doc.org/core-2.7.2/Thread.html]

(Ruby doc: Mutex)[https://ruby-doc.org/core-2.7.2/Mutex.html]

## Install
```
rbenv install 2.7.2

gem install bundler
bundler
```

## Run test
```
bundle exec rspec
```

## Run crawler_cli
```
bundle exec ruby crawler_cli.rb https://vkrabota.ru https://hh.ru https://career.habr.com https://spb.rabota.ru
```
