Rails.application.routes.draw do
  get 'employees_imports/new'
  get 'employees_imports/create'
  root 'companies#index'
  resources :clients
  resources :contractors
  resources :partner_companies
  resources :employees do
    collection do
      get :new_bulk
      post :create_bulk
      get :export
    end
  end
  resources :employees_imports, only: [:new, :create]
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
