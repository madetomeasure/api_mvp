require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Rails.application.secrets[:sidekiq_username] &&
  password == Rails.application.secrets[:sidekiq_password]
end if Rails.env.production?

MadeToMeasure::API.use Rack::Auth::Basic do |username, password|
  username == ENV['USERNAME'] &&
  password == ENV['PASSWORD']
end 

Rails.application.routes.draw do
  mount MadeToMeasure::API => '/'

  mount Sidekiq::Web => '/sidekiq'

  root :to => "home#index"
end
