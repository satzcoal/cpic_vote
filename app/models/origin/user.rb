# encoding: utf-8
require 'digest/sha2'

class Origin::User < ActiveRecord::Base
  has_history
  belongs_to :role, :class_name => 'Origin::Role', foreign_key: :role_id
  validates :name, :presence => true, :uniqueness => true
  validates :pname, :presence => true
  validates :password, :confirmation => true

  attr_reader :password
  validate :password_must_be_present

  after_destroy :ensure_an_admin_remains

  def self.authenticate_by_id(id, password)
    if user = find(id)
      self.do_authenticate(user, password)
    end
  end

  def self.authenticate(name, password)
    if user = find_by_name(name)
      self.do_authenticate(user, password)
    end
  end

  def self.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'asdf' + salt)
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def sidebar_items
    if role
      if role.adminFlag
        Origin::SidebarItem.where.not(:parent_id => nil)
      else
        role.sidebar_items
      end
    else
      []
    end
  end

  private

  def self.do_authenticate(user, password)
    if user.hashed_password == encrypt_password(password, user.salt)
      user
    end
  end

  def password_must_be_present
    errors.add(:password, '不能为空') unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def ensure_an_admin_remains
    if Origin::User.count.zero?
      raise '不能删除最后一个管理员'
    end
  end
end
