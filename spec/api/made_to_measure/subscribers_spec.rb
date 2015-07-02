require 'rails_helper'

describe 'MadeToMeasure::Subscribers' do
  
  context 'v0.1' do

    describe 'POST /subscribers' do

      let(:subscribers_path) { '/api/v0.1/subscribers' }
      let(:name)             { 'Flap Flappington, III' }
      let(:email)            { 'flap@flappington.com' }

      let(:payload) do
        {name: name, email: email}
      end

      it 'creates a subscriber' do
        post subscribers_path, payload
        expect(Subscriber.exists?(payload)).to be_truthy
      end

    end

  end

end
