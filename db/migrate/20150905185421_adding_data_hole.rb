class AddingDataHole < ActiveRecord::Migration
  def change
    create_table :subscriber_data do |t|
      t.integer :subscriber_id, null: false
      t.json :traits, null: false

      t.datetime :created_at, null: false

      t.index :subscriber_id
    end
  end
end
