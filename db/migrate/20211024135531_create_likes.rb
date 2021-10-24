class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :post
      t.references :comment

      t.timestamps
    end
  end
end
