# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  subject    :string(77)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from       :string
#  reply_to   :string
#

require 'rails_helper'

describe Message, type: :model do
  it "allows us to create messages and parts" do
    msg = Message.create(
      from:    'noreply@madetomeasure.io',
      html:    'thing',
      text:    'fun',
      subject: 'derp'
    )

    expect(msg.subject).to   eql("derp")
    expect(msg.html_body).to eql("thing")
    expect(msg.text_body).to eql("fun")
  end

  context 'multipart?' do
    it "returns true if message has more then one part" do
      expect(Message.new(text:'whatever')).not_to be_multipart
      expect(Message.new(html: "thing", text: "fun")).to be_multipart
    end
  end
end
