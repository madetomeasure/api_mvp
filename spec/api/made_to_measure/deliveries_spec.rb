require 'rails_helper'

describe 'MadeToMeasure::Deliveries' do
  describe 'get /messages' do
    let!(:delivery_1) { Fabricate(:delivery) }
    let!(:delivery_2) { Fabricate(:delivery) }
    let(:deliveries_path) { '/api/v0.1/deliveries' }

    it 'lists all deliveries' do
      get deliveries_path
      expect(JSON.parse(response.body)).to eql([
        delivery_1.as_json,
        delivery_2.as_json
      ])
    end

    it 'lists deliveries for a specific message' do
      delivery_2 = Fabricate(:delivery, message: delivery_1.message)
      get deliveries_path, message_id: delivery_1.message_id
      expect(JSON.parse(response.body)).to eql([
        delivery_1.as_json,
        delivery_2.as_json
      ])
    end
  end
end
