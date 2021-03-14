# require 'byebug'

module CrawlerCli
  module Crawler
    extend self

    def call(urls, worker = CrawlerCli::Worker, parser = CrawlerCli::Parser)
      jobs = urls.map { |url| job(parser, url) }
      worker.call(jobs)
    end

    protected

    def job(parser, url)
      proc { parser.call(url) }
    end
  end
end
