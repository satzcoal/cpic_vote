json.array!(@origin_users) do |origin_user|
  json.extract! origin_user, :id, :name, :hashed_password, :salt
  json.url origin_user_url(origin_user, format: :json)
end
