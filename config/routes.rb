require 'sidekiq/web'

IHeartPsychics::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    resource :admin
    resource :dashboard

    resources :clients
    resources :customer_service_representatives
    resources :manager_directors
    resources :packages
    resources :psychic_applications
    resources :psychics
    resources :website_admins
    resources :surveys
    resources :call_surveys
    resources :reviews
    resources :faqs
    resources :horoscopes
    resources :calls
    resources :newsletters do
      member do
        get 'deliver', action: :deliver, as: :deliver
        get 'reset'  , action: :reset  , as: :reset
      end
    end

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
      post 'do_transfer(:.format)'    , action: :do_transfer
      get  'do_transfer(:.format)'    , action: :do_transfer
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
  resources :psychic_applications do
    collection do
      get 'confirmation', action: :confirmation, as: :confirmation
    end
  end

  resources :surveys do
    member do
      post 'answer' , action: :answer, as: :answer
    end
  end

  get "/dashboard", to: "home#show", as: "dashboard"
  get "/unsubscribe/:id", to: "unsubscribe#unsubscribe", as: "unsubscribe"

  root to: 'home#show'
end
