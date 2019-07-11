class RenameColumnBirthDay < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :birth_day, :birthday
  end
end
