json.array!(@origin_roles) do |origin_role|
  json.extract! origin_role, :id, :name, :adminFlag
  json.url origin_role_url(origin_role, format: :json)
end
