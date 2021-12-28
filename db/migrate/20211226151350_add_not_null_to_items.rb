class AddNotNullToItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :price, false
    change_column_null :items, :quantity, false
  end
end
