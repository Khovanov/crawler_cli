require 'nokogiri'
require 'httparty'

module CrawlerCli
  module Parser
    extend self

    def call(url, client = HTTParty)
      error, status, text = parse(url, client)
      message(url, error, status, text)
    end

    protected

    def parse(url, client)
      error, status, text = nil
      response = request(url, client)
      status = response.code
      if response.success?
        text = content(document(response.parsed_response))
      end
    rescue StandardError => error
      # HTTParty::Error, Timeout::Error, SocketError etc.
      error = error.message
    ensure
      return [error, status, text]
    end

    def request(url, client)
      client.get(url)
    end

    def document(html)
      Nokogiri::HTML(html)
    end

    def content(document)
      document.xpath('//head/title')&.last&.content
    end

    def message(url, error, status, text)
      return "URL: #{url}, Error: #{error}" if error
      return "URL: #{url}, Status: #{status}, Title: #{text}" if status == 200
      "URL: #{url}, Status: #{status}"
    end
  end
end
