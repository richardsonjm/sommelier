Rails.application.routes.draw do
  resources :wines
  root 'wines#index'
  get 'load_catalog', to: 'wine_dot_com#load_catalog'
  get 'dashboard', to: 'pages#dashboard'
end
