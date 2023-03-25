class CreateEntriesGroupsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :entries_groups, id: false do |t|
      t.references :entry, foreign_key: true
      t.references :group, foreign_key: true
    end

    add_index :entries_groups, [:entry_id, :group_id], unique: true
  end
end
