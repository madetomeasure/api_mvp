require 'rails_helper'

describe 'MadeToMeasure::Deliveries' do
  describe 'get /messages' do
    let!(:d1) { Fabricate(:delivery) }
    let!(:d2) { Fabricate(:delivery) }
    let(:deliveries_path) { '/api/v0.1/deliveries' }

    it 'lists all deliveries' do
      get deliveries_path
      expect(JSON.parse(response.body)).to eql([
        d1.as_json,
        d2.as_json
      ])
    end

    it 'lists deliveries for a specific message' do
      d2 = Fabricate(:delivery, message: d1.message)
      get deliveries_path, message_id: d1.message_id
      expect(JSON.parse(response.body)).to eql([
        d1.as_json,
        d2.as_json
      ])
    end
  end
end
