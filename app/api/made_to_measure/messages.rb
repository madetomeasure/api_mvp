module MadeToMeasure

  class Messages < Grape::API

    desc 'Create a message'
    params do
      requires :subject, type: String, desc: 'A subject.'
      optional :text, type: String, desc: 'A text body.'
      optional :html, type: String, desc: 'An html body.'

      at_least_one_of :text, :html
    end
    post '/messages' do
      Message.create!({
        subject: params[:subject],
        text: params[:text],
        html: params[:html],
      })
    end

    desc 'Get a list of messages'
    params do
      optional :page, type: Integer, desc: 'Page number'
    end
    get '/messages' do
      Message.page(params[:page])
    end

  end

end
