require 'rails_helper'

describe Message, type: :model do
  it "allows us to create messages and parts" do
    msg = Message.create(html: "thing", text: "fun")
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
