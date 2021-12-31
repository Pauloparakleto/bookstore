class RemoveNotNullToPriceAuditBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :audit_books, :price, true
  end
end
