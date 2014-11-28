class Origin::RoleItemShip < ActiveRecord::Base
  has_history
  belongs_to :role, :class_name => 'Origin::Role'
  belongs_to :sidebar_item, :class_name => 'Origin::SidebarItem'
end
