# MessageDeliveryWorker handles delivering messages
# based on the Message model
class MessageDeliveryWorker
  include Sidekiq::Worker

  class Mailer < ActionMailer::Base
    default from: 'noreply@madetomeasure.io'

    def message_email(subscriber_id, message_id)
      subscriber = Subscriber.find(subscriber_id)
      message    = Message.find(message_id)

      headers = {
        to:       subscriber.email,
        from:     message.from,
        reply_to: message.reply_to,
        subject:  message.subject
      }

      # FIXME message needs to get rendered with user specific data with templating
      mail(headers) do |f|
        f.html { message.html_body.to_s.html_safe }
        f.text { message.text_body }
      end
    end
  end

  def perform(message_id)
    message = Message.find(message_id)

    Subscriber.find_each do |sub|
      delivery = Delivery.create!(subscriber: sub, message: message)
      SubscriberMessageDeliveryWorker.perform_async(delivery.id)
    end

    # FIXME: message should have some sort of delivered boolean that gets
    # set when all teh emailz are sent
  end

end
