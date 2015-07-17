class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      # http://stackoverflow.com/questions/1592291/what-is-the-email-subject-length-limit
      t.string :subject, limit: 77, null: false
      t.timestamps null: false
    end

    create_table :message_parts do |t|
      t.string :mime_type, null: false
      t.text :body, null: false
      t.integer :message_id, null: false
      t.timestamps null: false
    end

    add_foreign_key :message_parts, :messages, column: :message_id
    add_index :message_parts, [:message_id, :mime_type], unique: true
  end
end
