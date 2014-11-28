json.array!(@origin_sites) do |origin_site|
  json.extract! origin_site, :id, :logo, :title, :isAuthorize, :isRole, :isSidebar, :isTopbar, :isNavbar
  json.url origin_site_url(origin_site, format: :json)
end
