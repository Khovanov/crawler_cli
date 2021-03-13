require 'nokogiri'
require 'httparty'

module CrawlerCli
  class Parser
    class << self
      def call(url, client = HTTParty)
        text, status, text, error = nil
        begin
          response = request(url, client)
        rescue StandardError => error
          # HTTParty::Error, Timeout::Error, SocketError etc.
          error = error.message
        else
          status = response.code
          if response.success?
            text = content(document(response.parsed_response))
          end
        end
        message(url, status, text, error)
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

      def message(url, status, text, error)
        return "URL: #{url}, Error: #{error}" if error
        return "URL: #{url}, Status: #{status}, Title: #{text}" if text
        "URL: #{url}, Status: #{status}"
      end
    end
  end
end
