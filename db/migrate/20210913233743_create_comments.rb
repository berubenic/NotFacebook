class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :post, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
