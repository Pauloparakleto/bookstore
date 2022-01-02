class CreateAuditAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_authors do |t|
      t.integer :admin_id
      t.string :first_name
      t.string :last_name
      t.integer :author_id

      t.timestamps
    end
  end
end
