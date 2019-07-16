class AddColumnDescriptionToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :description, :text
  end
end
