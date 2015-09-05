require 'spec_helper'

describe MessageDeliveryWorker do
  around do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  let!(:message) { Fabricate(:message) }
  let!(:sub) { Fabricate(:subscriber) }
  let!(:sub2) { Fabricate(:subscriber) }

  it 'delivers message to each subscriber' integration: true do
    described_class.new.perform(message.id)
    d = ActionMailer::Base.deliveries
    expect(d.first.to).to eql([sub.email])
    expect(d.last.to).to eql([sub2.email])

    msg = d.first.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end

  it 'creates delivery for each subscriber' integration: true do
    described_class.new.perform(message.id)
    expect(sub.deliveries.first.message).to eql(message)
    expect(sub.deliveries.last.message).to eql(message)
  end
end
