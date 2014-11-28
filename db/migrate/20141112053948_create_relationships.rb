class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :info_relationships do |t|
      t.string :rid
      t.string :shortName
      t.string :name
      t.string :contact
      t.string :email
      t.string :tel
      t.string :fax
      t.string :address
      t.string :zip
      t.string :bank
      t.string :bankAccountNum
      t.string :bankAccountName
      t.integer :deposit
      t.integer :alarmMoney
      t.integer :payType
      t.boolean :rebateFlag
      t.integer :upper_id
      t.integer :lower_id
      t.string :type
      t.integer :tmp_rid
      t.string :mobile_tel

      t.timestamps
    end
  end
end
