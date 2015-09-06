module MadeToMeasure
  class Deliveries < Grape::API
    desc 'list message deliveries'
    params do
      optional :message_id,  type: String, desc: 'ID of message to list deliveries for'
      optional :page, type: Integer, desc: 'Page number'
    end
    get '/deliveries' do
      message_id = params[:message_id]
      q = Delivery.all.order('delivered_at DESC NULLS FIRST')
      q.where!(message_id: message_id) if message_id.present?
      q.page(params[:page])
    end
  end
end
