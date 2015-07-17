require 'rails_helper'

describe 'MadeToMeasure::Messages' do
  context 'v0.1' do
    let(:subject)  { 'Spam' }
    let(:html) { '<h1>viagra</h1>' }
    let(:messages_path) { '/api/v0.1/messages' }

    describe 'POST /messages' do
      it 'creates a message' do
        post messages_path, {subject: subject, html: html}
        expect(Message.exists?(subject: subject)).to be_truthy
      end
    end

    describe 'GET /messages' do
      let!(:message) do
        Message.create!(subject: subject, html: html)
      end

      it 'returns a list of messages' do
        get messages_path
        expect(response.body).to include(message.to_json)
      end

      it 'paginates' do
        get messages_path, page: 2
        expect(response.body).to eq('[]')
      end
    end
  end
end
