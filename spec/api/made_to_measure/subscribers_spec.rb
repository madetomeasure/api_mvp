require 'rails_helper'

describe 'MadeToMeasure::Subscribers' do
  
  context 'v0.1' do

    let(:name)  { 'Flap Flappington, III' }
    let(:email) { 'flap@flappington.com' }

    describe 'POST /subscribers' do

      let(:subscribers_path) { '/api/v0.1/subscribers' }

      let(:payload) do
        {name: name, email: email}
      end

      it 'creates a subscriber' do
        post subscribers_path, payload
        expect(Subscriber.exists?(payload)).to be_truthy
      end

    end

    describe 'DELETE /subscribers/:id' do

      let(:subscriber_path) { "/api/v0.1/subscribers/#{subscriber.id}" }

      let(:subscriber) do
        Subscriber.create!(name: name, email: email)
      end

      it 'deletes a subscriber' do
        delete subscriber_path 
        result = Subscriber.exists?(id: subscriber.id) 
        
        expect(result).to be_falsey
      end
    end

  end

end
