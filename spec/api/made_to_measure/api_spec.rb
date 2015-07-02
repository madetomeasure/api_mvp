require 'rails_helper'

describe 'MadeToMeasure::API' do

  context 'v0.1' do

    describe 'GET /status' do

      let(:status_path) { '/api/v0.1/status' }
      let(:status)      { 'my hovercraft is full of eels' }

      before do
        get status_path
      end

      it 'resolves' do
        expect(response.status).to be(200)
      end

      it 'returns a JSON encoded status' do
        body = JSON.parse(response.body).fetch('status')
        expect(body).to eq(status)
      end

    end

  end

end
