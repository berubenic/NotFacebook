class CreateDeletionRequest < ActiveRecord::Migration[6.1]
  def change
    create_table :deletion_requests do |t|
      t.string :provider
      t.string :uid
      t.string :pid
      t.index %w[uid provider], name: 'id_uid_provider', unique: true

      t.timestamps
    end
    add_index :deletion_requests, :pid
  end
end
