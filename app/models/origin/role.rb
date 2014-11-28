class Origin::Role < ActiveRecord::Base
  has_history
  has_many :users, :class_name => 'Origin::User'
  has_many :role_item_ships, :class_name => 'Origin::RoleItemShip', dependent: :destroy, autosave: true
  has_many :sidebar_items, :class_name => 'Origin::SidebarItem', through: :role_item_ships
  validates_presence_of :name
end
