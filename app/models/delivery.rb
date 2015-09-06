# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  message_id    :integer
#  delivered_at  :datetime
#

class Delivery < ActiveRecord::Base
  belongs_to :message
  belongs_to :subscriber

  def delivered!
    update_attributes!(delivered_at: Time.now.utc)
  end
end
