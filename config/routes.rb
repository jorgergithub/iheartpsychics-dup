IHeartPsychics::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resource :admin
    resource :dashboard
    resources :clients
    resources :packages

    get "/debug", to: "debug#index"
  end

  resources :calls do
    collection do
      post 'notify(:.format)'         , action: :notify
      get  'notify(:.format)'         , action: :notify
      post 'user(:.format)'           , action: :user
      get  'user(:.format)'           , action: :user
      post 'pin(:.format)'            , action: :pin
      get  'pin(:.format)'            , action: :pin
      post 'transfer(:.format)'       , action: :transfer
      get  'transfer(:.format)'       , action: :transfer
      post 'to_transfer(:.format)'    , action: :to_transfer
      get  'to_transfer(:.format)'    , action: :to_transfer
      post 'topup(:.format)'          , action: :topup
      get  'topup(:.format)'          , action: :topup
      post 'buy_minutes(.:format)'    , action: :buy_minutes
      get  'buy_minutes(.:format)'    , action: :buy_minutes
      post 'confirm_minutes(:.format)'  , action: :confirm_minutes
      get  'confirm_minutes(:.format)'  , action: :confirm_minutes
      post 'call_finished(:.format)'  , action: :call_finished
      get  'call_finished(:.format)'  , action: :call_finished
    end
  end

  resource :client do
    resources :client_phones, shallow: true
    member do
      get   'reset_pin'       , action: :reset_pin, as: :reset_pin
      patch 'reset_pin'       , action: :reset_pin
      get   'add_minutes'     , action: :add_minutes, as: :add_minutes
      patch 'add_minutes'     , action: :add_minutes
      get   'make_favorite'   , action: :make_favorite, as: :make_favorite
      get   'remove_favorite' , action: :remove_favorite, as: :remove_favorite
    end
  end

  resource :psychic do
    collection do
      get 'search', action: :search, as: :search
    end
  end

  resource :customer_service_representative

  resources :orders

  get "/dashboard", to: "home#show", as: "dashboard"

  root to: 'home#show'
end
