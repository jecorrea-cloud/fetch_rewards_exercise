Rails.application.routes.draw do
  # resources :transactions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/balances', to: 'transactions#current_balances'
  post '/add_transaction', to: 'transactions#create_transaction'
  post '/spend_points', to: 'transactions#spend_pts'

  get '/search_payer', to: 'transactions#search_p'
  get '/search_timestamp', to: 'transactions#search_t'
end
