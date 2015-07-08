require 'rails_helper'

describe Message, type: :model do
  context 'plaintext' do
    let(:message) do
      Message.new(message_headers: [ContentType.plaintext])
    end

    it 'is plaintext' do
      expect(message).to be_plaintext
    end
  end

  context 'html' do
    let(:message) do
      Message.new(message_headers: [ContentType.html])
    end

    it 'is html' do
      expect(message).to be_html
    end
  end

  context 'multipart' do
    let(:message) do
      Message.new(parts: [Message.new], message_headers: [ContentType.multipart])
    end

    it 'is multipart' do
      expect(message).to be_multipart
    end
  end
end
