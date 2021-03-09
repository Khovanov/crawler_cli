# frozen_string_literal: true
require_relative 'lib/crawler_cli'

urls = ARGV
raise 'Undefined urls' if urls.empty?

messages = CrawlerCli::Crawler.call(urls)
puts messages

# Example run:
# bundle exec ruby crawler_cli.rb https://vkrabota.ru https://hh.ru https://career.habr.com https://spb.rabota.ru
