class AddingDataHole < ActiveRecord::Migration
  def change
    add_column :subscribers, :metadata, :json
  end
end
