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

      let(:subscriber_json) do
        ::ActiveModel::ArraySerializer.new([subscriber]).to_json
      end

      it 'returns a list of subscribers' do
        get subscribers_path

        expect(response.body).to include(subscriber_json)
      end

      it 'paginates' do
        get subscribers_path, page: 2
        expect(response.body).to eq('{"subscribers":[]}')
      end
    end

    describe 'update a subscriber' do
      let(:subscriber) do
        Subscriber.create!(name: name, email: email)
      end

      let(:params) do
        {
          name: "New Name Flappington",
          metadata: {
            zomg: "Stuff"
          },
          id: subscriber.id.to_s
        }.as_json
      end

      context 'PUT /subscribers/:id' do
        it 'updates a persons name' do
          expect(UpdateSubscriber).to receive(:without_existing).with(params)

          put subscriber_path, params
        end

      end

      describe 'PATCH /subscribers/:id' do
        it 'updates a persons name' do
          expect(UpdateSubscriber).to receive(:with_existing).with(params)

          patch subscriber_path, params
        end
      end

    end
  end
end
