# == Schema Information
#
# Table name: message_parts
#
#  id         :integer          not null, primary key
#  mime_type  :string           not null
#  body       :text             not null
#  message_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe MessagePart, type: :model do
  context 'text' do
    let(:message_part) do
      described_class.new(mime_type: ContentType.text)
    end

    it 'is text' do
      expect(message_part).to be_text
    end
  end

  context 'html' do
    let(:message_part) do
      described_class.new(mime_type: ContentType.html)
    end

    it 'is html' do
      expect(message_part).to be_html
    end
  end
end
