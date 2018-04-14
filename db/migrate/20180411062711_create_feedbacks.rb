# cheema feedbacks
class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.boolean :like
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
