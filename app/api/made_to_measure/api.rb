module MadeToMeasure
  # Global API configuration
  # Mostly setting that the API is json
  # Version 0.1
  class API < Grape::API
    use Rack::Auth::Basic do |u, pass|
      u == ENV['USERNAME'] && pass == ENV['PASSWORD']
    end if Rails.env.production?

    prefix 'api'
    version 'v0.1', using: :path

    format :json

    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers do
      def render_collection(query)
        page = params.fetch(:page, 1)
        paginated = query.page(page)
        render paginated, meta: { page: page, total: query.count, current_page_count: paginated.count }, meta_key: :pagination_info
      end
    end

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
