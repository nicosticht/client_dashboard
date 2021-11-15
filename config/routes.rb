Rails.application.routes.draw do
  root 'companies#index'
  resources :clients
  resources :contractors
  resources :companies
  resources :partner_companies
  resources :employee_imports
  resources :employees do
  	collection { post :import }
  end
  get 'items_imports/new'
  get 'items_imports/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
