class SubscriberSerializer < ActiveModel::Serializer
  attributes :id
  attributes :name

  has_one :subscriber_datum
end
