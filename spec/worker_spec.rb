# frozen_string_literal: true
require_relative '../lib/crawler_cli/worker'

RSpec.describe CrawlerCli::Worker, "call" do
  context "with array jobs" do
    let(:job_easy) { proc { sleep(0.5); 'result job_easy' } }
    let(:job_normal) { proc { sleep(1); 'result job_normal' } }
    let(:job_hard) { proc { sleep(1.5); 'result job_hard' } }
    let(:jobs) { [job_easy, job_normal, job_hard] }

    it "return array of job results" do
      result = described_class.call(jobs)
      expect(result).to contain_exactly(
                          'result job_easy',
                          'result job_normal',
                          'result job_hard')
    end
  end
end
