#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#  在这里可以做系统部署数据初始化
# e.g.: 创建管理员用户、初始化权限、基本信息配置
#删除所有用户
#User.delete_all
#admin= User.Create([{name: 'admin'}])
#Category.delete_all
#caretegories = Category.Create([{Name: "", Type: ""}]

#初始化 菜单
site = Origin::Site.first
site = Origin::Site.new unless site
site.title = '中国专利信息中心投票系统' unless site.title
site.sidebar_items.destroy_all
if (site.sidebar_items.empty?)
  site.sidebar_items.build(name: '首页', url: '/')

  main_item = site.sidebar_items.build(name: '投票列表', url: '#')
  main_item.sub_items.build(name: '工会委员选举', url: '/vote/gonghui')

  toupiao_item = site.sidebar_items.build(name: '投票管理', url: '#')
  toupiao_item.sub_items.build(name: '所有投票', url: '/vote/votes')

  xitong_item = site.sidebar_items.build(name: '系统管理', url: '#')
  xitong_item.sub_items.build(name: '用户管理', url: '/origin/users')
  xitong_item.sub_items.build(name: '角色管理', url: '/origin/roles')
  xitong_item.sub_items.build(name: '菜单项管理', url: '/origin/sidebar_items')
end
site.save


#权限
role = Origin::Role.find_or_create_by(name: '超级管理员') do |r|
  r.adminFlag = true
  r.save
end

#管理员 admin
Origin::User.find_or_create_by(name: 'admin') do |user|
  user.hashed_password = 'b38dccdaff403e93e883e12ac0decabfd3a59f77acddc375306e4e2223dcb09a'
  user.salt = '702160211035000.14183056038145636'
  user.role_id = role.id
  user.pname = "123"
  user.save
end

#一般管理员
role = Origin::Role.find_or_create_by(name: '一般管理员') do |r|
  r.adminFlag = false
  Origin::SidebarItem.where.not(:parent_id => nil).each_with_index do |item, index|
    next if index % 2 == 0
    r.sidebar_items.push(item)
  end
  r.save
end

#用户lee
Origin::User.find_or_create_by(name: 'lee') do |user|
  user.hashed_password = '673c6ca5dec5d04781ea78e5f9f952193c06a199583c436d4a99fe71e95dcf13'
  user.salt = '368465400.6921654939247173'
  user.role_id = role.id
  user.pname = "456"
  user.save
end
