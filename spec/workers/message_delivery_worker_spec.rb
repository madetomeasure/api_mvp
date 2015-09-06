require 'spec_helper'

describe MessageDeliveryWorker do
  around do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  let!(:message)     { Fabricate(:message) }
  let!(:subscriber)  { Fabricate(:subscriber) }
  let!(:subscriber2) { Fabricate(:subscriber) }

  it 'delivers message to each subscriber', integration: true do
    described_class.new.perform(message.id)
    deliveries = ActionMailer::Base.deliveries
    expect(deliveries.first.to).to eql([subscriber.email])
    expect(deliveries.last.to).to eql([subscriber2.email])

    msg = deliveries.first.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end

  it 'creates delivery for each subscriber', integration: true do
    described_class.new.perform(message.id)
    expect(subscriber.deliveries.first.message).to eql(message)
    expect(subscriber.deliveries.last.message).to eql(message)
  end
end
