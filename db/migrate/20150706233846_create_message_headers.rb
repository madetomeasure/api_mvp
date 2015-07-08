class CreateMessageHeaders < ActiveRecord::Migration
  def change
    create_table :message_headers do |t|
      t.string :key, null: false
      t.string :value, null: false

      t.timestamps null: false
    end
  end
end
