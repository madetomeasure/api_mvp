Rails.application.routes.draw do
  mount MadeToMeasure::API => '/'

  root :to => "home#index"
end
