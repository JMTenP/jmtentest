Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'

  get '/payments/', to: 'payments#index' 
  get '/payments/:id', to: 'payments#edit' 
  post '/payments/', to: 'payments#create'
  patch '/payments/:id', to: 'payments#update'


  get '/employees/', to: 'employees#index' 
  

  # resources :accounts
  # resources :paymentes,only: [:index, :create, :show, :update, :destroy]
  # resources :employees do
  #   resources :notes, only: [:index, :create, :show, :update, :destroy]
  #   put :activate, on: :member
  #   put :deactivate, on: :member
  # end

  # resources :payments do
  #   resources :notes, only: [:index, :create, :show, :update, :destroy]
  #   put :activate, on: :member
  #   put :deactivate, on: :member
  # end

end
