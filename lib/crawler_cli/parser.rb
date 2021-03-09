require 'nokogiri'
require 'httparty'

module CrawlerCli
  class Parser
    class << self
      def call(url, client = HTTParty)
        begin
          response = request(url, client)
        rescue StandardError => error
          # HTTParty::Error, Timeout::Error, SocketError etc.
          status = error.message
        else
          status = response.code
          if response.success?
            text = content(document(response.parsed_response))
          end
        end
        message(url, status, text)
      end

      protected

      def request(url, client)
        client.get(url)
      end

      def document(html)
        Nokogiri::HTML(html)
      end

      def content(document)
        document.xpath('//head/title')&.last&.content
      end

      def message(url, status, text)
        "URL: #{url}, Status: #{status}, Title: #{text}"
      end
    end
  end
end
