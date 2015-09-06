# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  message_id    :integer
#  delivered_at  :datetime
#

require 'spec_helper'

describe Delivery do
  describe 'mark_success!' do
    it 'sets delivered_at' do
      sub = Fabricate(:subscriber)
      msg = Fabricate(:message)
      d = Delivery.create(subscriber: sub, message: msg)
      expect(d.delivered_at).to be_nil
      now = Time.now
      Timecop.freeze(now) do
        d.delivered!
        expect(d.delivered_at).to eql(now)
      end
    end
  end
end
