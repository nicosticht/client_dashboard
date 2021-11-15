Rails.application.routes.draw do
  root 'companies#index'
  resources :clients
  resources :contractors
  resources :companies
  resources :partner_companies
  resources :employee_imports, only: %i[new create]
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
