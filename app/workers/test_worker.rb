class TestWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message)
    logger.info "Testing sidekiq on docker: #{message}"
  end
end