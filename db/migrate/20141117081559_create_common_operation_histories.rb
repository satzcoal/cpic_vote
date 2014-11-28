class CreateCommonOperationHistories < ActiveRecord::Migration
  def change
    create_table :common_operation_histories do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :type
      t.string :detail
      t.string :op_type

      t.timestamps
    end
  end
end
