# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  message_id    :integer
#  delivered_at  :datetime
#

Fabricator(:delivery) do
  subscriber
  message
end
