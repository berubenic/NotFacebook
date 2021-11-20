class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friendship, foreign_key: true
      t.references :like, foreign_key: true
      t.references :comment, foreign_key: true
      t.boolean :seen, default: :false

      t.timestamps
    end
  end
end
