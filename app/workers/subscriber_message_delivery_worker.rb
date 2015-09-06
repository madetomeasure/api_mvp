# Delivers email messages
class SubscriberMessageDeliveryWorker
  include Sidekiq::Worker

  # Handles mailing for the Messages
  class Mailer < ActionMailer::Base
    default from: 'noreply@madetomeasure.io'

    def message_email(subscriber_id, message_id)
      sub = Subscriber.find(subscriber_id)
      msg = Message.find(message_id)
      renderer = RenderMessage.new(msg, sub)

      # FIXME: message needs to get rendered with user
      # specific data with templating
      mail(to: sub.email, subject: msg.subject) do |f|
        f.html { renderer.html.html_safe }
        f.text { renderer.text }
      end
    end
  end

  def perform(delivery_id)
    d = Delivery.find(delivery_id)
    Mailer.message_email(d.subscriber_id, d.message_id).deliver_now
    d.delivered! # prolly a lil optimistic..
  end
end
