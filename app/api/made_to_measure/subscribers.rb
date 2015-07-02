module MadeToMeasure

  class Subscribers < Grape::API

    desc 'Add a subscriber'
    post '/subscribers' do
      Subscriber.create!({
        name:  params[:name],
        email: params[:email]
      })
    end

  end

end
