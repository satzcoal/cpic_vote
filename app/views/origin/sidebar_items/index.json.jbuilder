json.array!(@origin_sidebar_items) do |origin_sidebar_item|
  json.extract! origin_sidebar_item, :id, :name, :url, :site_id, :parent_id
  json.url origin_sidebar_item_url(origin_sidebar_item, format: :json)
end
