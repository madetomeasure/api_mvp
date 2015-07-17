require 'rails_helper'

describe MessagePart, type: :model do
  context 'plaintext' do
    let(:message_part) do
      described_class.new(mime_type: ContentType.plaintext)
    end

    it 'is plaintext' do
      expect(message_part).to be_plaintext
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

  context 'multipart' do
    let(:message_part) do
      described_class.new(mime_type: ContentType.multipart)
    end

    it 'is multipart' do
      expect(message_part).to be_multipart
    end
  end
end
