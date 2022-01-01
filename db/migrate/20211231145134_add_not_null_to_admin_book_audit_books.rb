class AddNotNullToAdminBookAuditBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :audit_books, :admin_id, false
    change_column_null :audit_books, :book_id, false
  end
end
