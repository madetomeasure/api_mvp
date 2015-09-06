# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  metadata   :json
#

# This handles basic serialization for Subscribers
class SubscriberSerializer < ActiveModel::Serializer
  attributes :id, :name, :metadata
end
