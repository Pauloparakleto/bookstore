class AddDefaultUnpublishedToBook < ActiveRecord::Migration[6.1]
  def change
    change_column_default :books, :published, false
  end
end
