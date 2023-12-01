Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  resources :categories
  resources :transactions

  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  # root "posts#index"
  root 'categories#index', as:'categories_index'
  get "transactions" => "transactions#index", as: 'transactions_index'
  get "report_generator" => "transactions#report_generator", as: 'transactions_report_generator'
  get "report" => "transactions#report", as: 'transactions_report'
  get "graph_report" => "transactions#graph_report", as: 'transactions_graph_report'
  
end
