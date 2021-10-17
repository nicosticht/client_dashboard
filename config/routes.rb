Rails.application.routes.draw do
  root 'companies#index'
  resources :clients
  resources :contractors
  resources :partner_companies
  resources :employees do
    collection do
      get :new_bulk
      post :create_bulk
    end
  end
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
