class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :city
      t.string :postcode
      t.float :latitude
      t.float :longitude
      t.string :items 

      t.references :user
      t.timestamps
    end
  end
end
