require 'spec_helper'

describe MessageDeliveryWorker do
  around do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  it 'delivers message to each subscriber' do
    message     = Fabricate(:message)
    subscriber  = Fabricate(:subscriber)
    subscriber2 = Fabricate(:subscriber)

    described_class.new.perform(message.id)
    deliveries = ActionMailer::Base.deliveries
    expect(deliveries.first.to).to eql([subscriber.email])
    expect(deliveries.last.to).to eql([subscriber2.email])

    msg = deliveries.first.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end
end
