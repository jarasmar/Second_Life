class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.references :user
      t.string :address
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
  end
end
