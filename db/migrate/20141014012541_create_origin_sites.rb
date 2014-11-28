class CreateOriginSites < ActiveRecord::Migration
  def change
    create_table :origin_sites do |t|
      t.string :logo
      t.string :title
      t.boolean :isAuthorize
      t.boolean :isRole
      t.boolean :isSidebar
      t.boolean :isTopbar
      t.boolean :isNavbar

      t.timestamps
    end
  end
end
