# This handles basic serialization for Subscribers
class SubscriberSerializer < ActiveModel::Serializer
  attributes :id, :name, :metadata
end
