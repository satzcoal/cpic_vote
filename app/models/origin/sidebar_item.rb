class Origin::SidebarItem < ActiveRecord::Base
  has_history
  belongs_to :site, :class_name => 'Origin::Site', foreign_key: :site_id
  belongs_to :parent_item, :class_name => 'Origin::SidebarItem', foreign_key: :parent_id
  has_many :sub_items, :class_name => 'Origin::SidebarItem', foreign_key: :parent_id, :dependent => :destroy, autosave: true
  has_many :role_item_ships, :class_name => 'Origin::RoleItemShip', dependent: :destroy
  has_many :roles, :class_name => 'Origin::Role', through: :role_item_ships
end
