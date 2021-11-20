class AddCategoryColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :category, :integer
  end
end
