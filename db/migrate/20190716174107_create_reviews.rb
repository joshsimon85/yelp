class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :user_id, :business_id
      t.timestamps
    end
  end
end
