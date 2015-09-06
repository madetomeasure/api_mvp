require 'rails_helper'

describe UpdateSubscriber do
  let(:subscriber) { Fabricate(:subscriber) }
  let(:traits) do
    {'gum_flavor' => 'Big red'}
  end

  let!(:subscriber_datum) do
    SubscriberDatum.create!(subscriber: subscriber, traits: traits)
  end

  let(:params) do
    {
      name: "Flapping ton the  3rd",
      traits: {
        favorite_food: "Poutine"
      },
      id: subscriber.id
    }.as_json
  end

  it 'updates with the existing data' do
    described_class.with_existing(params)

    datum = subscriber_datum.reload
    expect(datum.traits).to eq(params.fetch('traits').merge(traits))
  end

  it 'updates without the existing data' do
    described_class.without_existing(params)

    datum = subscriber_datum.reload
    expect(datum.traits).to eq(params.fetch('traits'))
  end
end
