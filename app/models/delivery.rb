class Delivery < ActiveRecord::Base
  belongs_to :message
  belongs_to :subscriber

  def delivered!
    update_attributes!(delivered_at: Time.now)
  end
end
