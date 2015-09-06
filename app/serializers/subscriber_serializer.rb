class SubscriberSerializer < ActiveModel::Serializer
  attributes :id
  attributes :name

  attributes :metadata
end
