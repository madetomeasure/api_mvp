# MessageDeliveryWorker handles delivering messages
# based on the Message model
class MessageDeliveryWorker
  include Sidekiq::Worker

  def perform(message_id)
    msg = Message.find(message_id)

    Subscriber.find_each do |sub|
      delivery = Delivery.create!(subscriber: sub, message: msg)
      SubscriberMessageDeliveryWorker.perform_async(delivery.id)
    end

    # FIXME: message should have some sort of delivered boolean that gets
    # set when all teh emailz are sent
  end
end
