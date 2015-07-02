require 'rails_helper'

describe 'MadeToMeasure::Subscribers' do
  
  context 'v0.1' do

    let(:name)  { 'Flap Flappington, III' }
    let(:email) { 'flap@flappington.com' }
    let(:subscribers_path) { '/api/v0.1/subscribers' }
    let(:subscriber_path) { "/api/v0.1/subscribers/#{subscriber.id}" }

    describe 'POST /subscribers' do
      let(:payload) do
        {name: name, email: email}
      end

      it 'creates a subscriber' do
        post subscribers_path, payload
        expect(Subscriber.exists?(payload)).to be_truthy
      end

    end

    describe 'DELETE /subscribers/:id' do
      let(:subscriber) do
        Subscriber.create!(name: name, email: email)
      end

      it 'deletes a subscriber' do
        delete subscriber_path 
        result = Subscriber.exists?(id: subscriber.id) 
        
        expect(result).to be_falsey
      end
    end

    describe 'GET /subscribers' do
      let!(:subscriber) do
        Subscriber.create!(name: name, email: email)
      end

      it 'returns a list of subscribers' do
        get subscribers_path

        expect(response.body).to include(subscriber.to_json)
      end

      it 'paginates' do
        get subscribers_path, page: 2
        expect(response.body).to eq('[]')
      end
    end

  end

end
