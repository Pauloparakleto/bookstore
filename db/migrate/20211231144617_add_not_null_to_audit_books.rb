class AddNotNullToAuditBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :audit_books, :price, false
  end
end
