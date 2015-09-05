class AddingDataHole < ActiveRecord::Migration
  def change
    create_table :subscriber_data do |t|
      t.integer :subscriber_id, null: false
      t.json :traits, null: false

      t.timestamps null: false

      t.index :subscriber_id, unique: true
    end
  end
end
