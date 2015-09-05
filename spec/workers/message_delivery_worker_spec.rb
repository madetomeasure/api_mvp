require 'spec_helper'

describe MessageDeliveryWorker do
  around do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  it 'delivers message to each subscriber' do
    message = Fabricate(:message)
    sub = Fabricate(:subscriber)
    sub2 = Fabricate(:subscriber)

    described_class.new.perform(message.id)
    d = ActionMailer::Base.deliveries
    expect(d.first.to).to eql([sub.email])
    expect(d.last.to).to eql([sub2.email])

    msg = d.first.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end
end
