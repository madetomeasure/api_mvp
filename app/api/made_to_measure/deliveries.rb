module MadeToMeasure
  # Handles queueing up deliveries for messages
  class Deliveries < Grape::API
    desc 'list message deliveries'
    params do
      optional :message_id, type: String,
                            desc: 'ID of message to list deliveries for'
      optional :page, type: Integer, desc: 'Page number'
    end
    get '/deliveries' do
      message_id = params[:message_id]
      query = Delivery.all.order('delivered_at DESC NULLS FIRST')
      query.where!(message_id: message_id) if message_id.present?

      render_collection(query)
    end
  end
end
