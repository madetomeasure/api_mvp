require 'rails_helper'

describe UpdateSubscriber do
  let(:metadata) do
    {'gum_flavor' => 'Big red'}
  end

  let(:subscriber) { Fabricate(:subscriber, metadata: metadata) }
  let(:params) do
    {
      name: "Flapping ton the  3rd",
      metadata: {
        favorite_food: "Poutine"
      },
      id: subscriber.id
    }.as_json
  end

  it 'updates with the existing data' do
    described_class.with_existing(params)

    expect(subscriber.reload.metadata).to eq(params.fetch('metadata')
                                            .merge(metadata))
  end

  it 'updates without the existing data' do
    described_class.without_existing(params)

    expect(subscriber.reload.metadata).to eq(params.fetch('metadata'))
  end
end
