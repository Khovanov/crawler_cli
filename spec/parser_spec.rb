# frozen_string_literal: true
require_relative '../lib/crawler_cli/parser'

RSpec.describe CrawlerCli::Parser, "call" do
  let(:url) { 'https://vkrabota.ru' }

  context "with valid response" do

    let(:parsed_response) { File.read('./spec/files/document.html') }
    let(:valid_message) { 'URL: https://vkrabota.ru, Status: 200, Title: text' }

    let(:valid_resp) do
      double('Response', code: 200, :success? => true,
        parsed_response: parsed_response)
    end

    let(:client) do
      client = double('Client')
      allow(client).to receive(:get)
                         .with(kind_of(String))
                         .and_return(valid_resp)
      client
    end

    it "return valid message" do
      result = described_class.call(url, client)
      expect(result).to eq(valid_message)
    end
  end

  context "with client exception" do
    let(:invalid_message) { "URL: https://vkrabota.ru, Status: StandardError, Title: " }

    let(:client_with_exception) do
      client = double('Client')
      allow(client).to receive(:get)
                         .with(kind_of(String))
                         .and_raise(StandardError)
      client
    end

    it "return invalid message" do
      result = described_class.call(url, client_with_exception)
      expect(result).to eq(invalid_message)
    end
  end
end
