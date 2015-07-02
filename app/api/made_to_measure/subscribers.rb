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

  end

end
