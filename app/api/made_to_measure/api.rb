module MadeToMeasure
  # Global API configuration
  # Mostly setting that the API is json
  # Version 0.1
  class API < Grape::API
    prefix 'api'
    version 'v0.1', using: :path

    format :json

    formatter :json, Grape::Formatter::ActiveModelSerializers

    get :status do 
      { status: 'my hovercraft is full of eels' }
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      Rack::Response.new({
        error_code: 404,
        error_message: e.message
      }.to_json, 404).finish
    end

    rescue_from :all do |e|
      Rack::Response.new({
        error_code: 500,
        error_message: e.message
      }.to_json, 500).finish
    end

    mount MadeToMeasure::Subscribers
    mount MadeToMeasure::Messages
    mount MadeToMeasure::Deliveries
  end
end
