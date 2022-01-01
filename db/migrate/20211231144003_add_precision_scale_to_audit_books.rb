class AddPrecisionScaleToAuditBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :audit_books, :price
    add_column :audit_books, :price, :decimal, precision: 10, scale: 2
  end
end
