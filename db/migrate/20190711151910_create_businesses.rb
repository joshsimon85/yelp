class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name, :address_1, :address_2, :city, :state, :phone
      t.text :tags
      t.integer :price
      t.timestamps
    end
  end
end
