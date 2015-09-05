require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'mtom' && password == 'basic elephantitis swagger'
end unless Rails.env.development?

Rails.application.routes.draw do
  mount MadeToMeasure::API => '/'

  mount Sidekiq::Web => '/sidekiq'

  root :to => "home#index"
end
