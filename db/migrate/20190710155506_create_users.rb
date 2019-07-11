class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fist_name, :last_name, :email, :password_digest, :city, :state
      t.date :birth_day
      t.text :about
      t.timestamps
    end
  end
end
