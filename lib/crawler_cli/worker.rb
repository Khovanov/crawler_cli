module CrawlerCli
  module Worker
    extend self

    def call(jobs)
      mutex = Mutex.new
      results = []
      threads = []

      jobs.each do |job|
        threads << Thread.new do
          message = job.call
          mutex.synchronize do
            results << message
          end
        end
      end

      threads.each(&:join)
      results
    end
  end
end
