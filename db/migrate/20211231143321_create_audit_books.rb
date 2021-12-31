class CreateAuditBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_books do |t|
      t.integer :admin_id
      t.integer :book_id
      t.string :title
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
