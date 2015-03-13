Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://192.168.254.10:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://192.168.254.10:6379' }
end