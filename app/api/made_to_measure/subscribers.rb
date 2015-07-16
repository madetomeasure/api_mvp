module MadeToMeasure

  class Subscribers < Grape::API

    desc 'Create a subscriber'
    params do
      requires :name,  type: String, desc: 'A name.'
      requires :email, type: String, desc: 'A unique email address.'
    end
    post '/subscribers' do
      Subscriber.create!({
        name:  params[:name],
        email: params[:email]
      })
    end

    desc 'Destroy a subscriber'
    params do
      requires :id, type: String, desc: 'A Subscriber ID.'
    end
    delete '/subscribers/:id' do
      Subscriber.find(params[:id]).destroy!
    end

    desc 'Get a list of subscribers'
    params do
      optional :page, type: Integer, desc: 'Page number'
    end
    get '/subscribers' do
      Subscriber.page(params[:page])
    end

    desc 'Update a single subscriber'
    params do
      requires :name, type: String, desc: 'The subscribers name'
    end
    post '/subscribers/:id' do
      # Seems crazy but email is a write only object
      # Or maybe it shouldn't be?
      # TODO
      subscriber = Subscriber.find(params[:id])
      subscriber.update_attribute(:name, params[:name])
      subscriber
    end

  end

end
