class RemoveUniqueConstraintFromActiveStorageBlobs < ActiveRecord::Migration[7.0]
  def up
    remove_index :active_storage_blobs, :key
  end

  def down
    add_index :active_storage_blobs, :key, unique: true
  end
end
