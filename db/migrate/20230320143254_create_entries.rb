class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string :name, null: false, limit: 100
      t.float :amount, null: false # , precision: 10, scale: 2
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
