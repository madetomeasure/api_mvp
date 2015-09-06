require 'spec_helper'

describe SubscriberMessageDeliveryWorker do
  let(:delivery) { Fabricate(:delivery) }
  it 'sends email' do
    subscriber = delivery.subscriber
    message = delivery.message

    subject.perform(delivery.id)
    message_delivery = ActionMailer::Base.deliveries.last
    expect(message_delivery.to).to eql([subscriber.email])

    msg = message_delivery.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end

  it 'sets delivered_at' do
    now = Time.now
    allow(Time).to receive(:now).and_return(now)
    subject.perform(delivery.id)
    expect(delivery.reload.delivered_at).to eq(now)
  end
end
