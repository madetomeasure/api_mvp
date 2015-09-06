class SubscriberMessageDeliveryWorker
  include Sidekiq::Worker

  class Mailer < ActionMailer::Base
    default from: 'noreply@madetomeasure.io'

    def message_email(subscriber_id, message_id)
      sub = Subscriber.find(subscriber_id)
      msg = Message.find(message_id)

      # FIXME message needs to get rendered with user specific data with templating
      mail(to: sub.email, subject: msg.subject) do |f|
        f.html { msg.html_body.to_s.html_safe }
        f.text { msg.text_body }
      end
    end
  end

  def perform(delivery_id)
    d = Delivery.find(delivery_id)
    Mailer.message_email(d.subscriber_id, d.message_id).deliver_now
    d.delivered! # prolly a lil optimistic..
  end
end
