class AddNotNullToAuditAuthor < ActiveRecord::Migration[6.1]
  def change
    change_column_null :audit_authors, :admin_id, false
    change_column_null :audit_authors, :author_id, false
  end
end
