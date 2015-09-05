class MessageDeliveryWorker
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

  def perform(message_id)
    msg = Message.find(message_id)

    Subscriber.find_each do |sub|
      Mailer.delay.message_email(sub.id, msg.id)
    end
  end
end
