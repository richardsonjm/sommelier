Rails.application.routes.draw do
  resources :wines
  root 'wines#index'
end
