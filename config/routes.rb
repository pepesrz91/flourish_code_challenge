Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'login' , to: 'users#login'
  post 'api/v1/user_events', to: 'user_events#event_handler'
  post 'api/v1/user/redeems', to: 'reward#user_redeems'
  get 'api/v1/rewards', to: 'reward#available_rewards'
end
