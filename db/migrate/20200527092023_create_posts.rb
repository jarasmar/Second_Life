class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, :limit => 100
      t.text :description, :limit => 5000
      t.references :user
      
      t.timestamps
    end
  end
end
