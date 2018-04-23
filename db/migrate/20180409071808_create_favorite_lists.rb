# Migration favorite list
class CreateFavoriteLists < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_lists do |t|
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
