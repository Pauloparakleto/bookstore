class AddPublishedToAuditBook < ActiveRecord::Migration[6.1]
  def change
    add_column :audit_books, :published, :boolean
  end
end
