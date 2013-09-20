require 'sidekiq/web'

IHeartPsychics::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
    :registrations => "registrations" }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    resource :admin
    resource :dashboard

    resources :clients
    resources :accountants
    resources :customer_service_representatives
    resources :manager_directors
    resources :packages
    resources :psychic_applications
    resources :psychics
    resources :website_admins
    resources :surveys
    resources :call_surveys
    resources :categories
    resources :horoscopes
    resources :calls
    resources :invoices do
      resources :payments
    end

    resources :newsletters do
      member do
        get 'deliver', action: :deliver, as: :deliver
        get 'reset'  , action: :reset  , as: :reset
      end
    end

    resources :reviews, :shallow => true do
      member do
        get 'mark_as_featured', action: :mark_as_featured, as: :mark_as_featured
        get 'unmark_as_featured', action: :unmark_as_featured, as: :unmark_as_featured
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
      post 'buy_credits(.:format)'    , action: :buy_credits
      get  'buy_credits(.:format)'    , action: :buy_credits
      post 'confirm_credits(:.format)'  , action: :confirm_credits
      get  'confirm_credits(:.format)'  , action: :confirm_credits
      post 'call_finished(:.format)'  , action: :call_finished
      get  'call_finished(:.format)'  , action: :call_finished
    end
  end

  resource :client do
    resources :client_phones, shallow: true
    member do
      get   'reset_pin'       , action: :reset_pin, as: :reset_pin
      patch 'reset_pin'       , action: :reset_pin
      get   'add_credits'     , action: :add_credits, as: :add_credits
      patch 'add_credits'     , action: :add_credits
      get   'make_favorite'   , action: :make_favorite, as: :make_favorite
      get   'remove_favorite' , action: :remove_favorite, as: :remove_favorite
    end
  end

  resource :psychic do
    resources :reviews, only: [], shallow: true do
      member do
        get 'mark_as_featured', action: :mark_as_featured, as: :mark_as_featured
        get 'unmark_as_featured', action: :unmark_as_featured, as: :unmark_as_featured
      end
    end

    resources :invoices

    collection do
      get 'search', action: :search, as: :search
    end
  end

  resource :customer_service_representative
  resource :accountant

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
