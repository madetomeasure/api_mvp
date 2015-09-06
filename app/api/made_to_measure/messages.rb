module MadeToMeasure

  class Messages < Grape::API

    desc 'Create a message'
    params do
      requires :subject, type: String, desc: 'A subject.'
      
      optional :text,     type: String, desc: 'A text body.'
      optional :html,     type: String, desc: 'An html body.'
      optional :from,     type: String, desc: 'A from address.'
      optional :reply_to, type: String, desc: 'A reply to address.'

      at_least_one_of :text, :html
    end
    post '/messages' do
      msg = Message.create!({
        # NOTE (cmhobbs) replace this when we have a concept of
        #      organizations and default addressen
        from:     (params[:from] || 'noreply@madetomeasure.io'),
        reply_to: params[:reply_to],
        subject:  params[:subject],
        text:     params[:text],
        html:     params[:html],
      })

      MessageDeliveryWorker.perform_async(msg.id)
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
