class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :parent_message_id
      t.timestamps null: false
    end

    add_foreign_key :messages, :messages, column: :parent_message_id
  end
end
