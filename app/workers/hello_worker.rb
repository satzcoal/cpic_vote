class HelloWorker
  include Sidekiq::Worker

  def perform(name)
    puts "Hello Sidekiq, i am #{name}"
  end
end