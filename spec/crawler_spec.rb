# frozen_string_literal: true
require_relative '../lib/crawler_cli/crawler'

RSpec.describe CrawlerCli::Crawler, "call" do
  context "with array links" do
    let(:message1) { 'message 1' }
    let(:message2) { 'message 2' }
    let(:messages) { [message1, message2] }

    let(:parser) do
      parser = double('Parser')
      allow(parser).to receive(:call)
                         .with(kind_of(String))
                         .and_return(message1, message2)
      parser
    end

    let(:worker) do
      worker = double('Worker')
      allow(worker).to receive(:call)
                         .with(kind_of(Array))
                         .and_return(messages)
      worker
    end

    it "return array of messages" do
      result = described_class.call(['url1', 'url2'], worker, parser)
      expect(result).to contain_exactly(message1, message2)
    end
  end
end
