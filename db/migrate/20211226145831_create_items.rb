class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :order_id
      t.string :name
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
