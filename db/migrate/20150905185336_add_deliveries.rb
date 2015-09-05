class AddDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :subscriber_id
      t.integer :message_id
      t.datetime :delivered_at
    end
  end
end
