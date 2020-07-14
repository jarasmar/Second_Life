class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item
      t.string :availability

      t.references :post
      t.timestamps
    end
  end
end
