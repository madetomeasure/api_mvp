require 'spec_helper'

describe MessageDeliveryWorker do
  around do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  it 'delivers message to each subscriber' do
    message = Message.create!(subject: 'things', html: 'things', text: 'stufffs')
    sub = Subscriber.create!(email: 'steve@steve.com', name: 'derp herp')
    sub2 = Subscriber.create!(email: 'steve2@steve.com', name: 'derp herp')

    described_class.new.perform(message.id)
    d = ActionMailer::Base.deliveries
    expect(d.first.to).to eql([sub.email])
    expect(d.last.to).to eql([sub2.email])

    msg = d.first.to_s
    expect(msg).to include(message.html_body)
    expect(msg).to include(message.text_body)
  end
end
