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
    resources :accountants
    resources :call_surveys
    resources :calls
    resources :categories
    resources :clients
    resources :customer_service_representatives
    resources :horoscopes

    resources :invoices, only: :show do
      resources :payments

      collection do
        get 'paid', action: :paid, as: :paid
        get 'pending', action: :pending, as: :pending
      end
    end

    resources :manager_directors

    resources :newsletters do
      member do
        get 'deliver', action: :deliver, as: :deliver
        get 'reset'  , action: :reset  , as: :reset
      end
    end

    resources :orders, :except => [:edit, :update, :destroy] do
      resource :refunds, :only => :create
    end

    resources :packages
    resources :psychic_applications
    resources :psychics

    resources :reviews, :shallow => true do
      member do
        get 'mark_as_featured', action: :mark_as_featured, as: :mark_as_featured
        get 'unmark_as_featured', action: :unmark_as_featured, as: :unmark_as_featured
      end
    end

    resources :schedule_jobs, :only => [:index, :edit, :update]
    resources :surveys
    resources :website_admins

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
        get 'mark_as_featured'   , action: :mark_as_featured   , as: :mark_as_featured
        get 'unmark_as_featured' , action: :unmark_as_featured , as: :unmark_as_featured
      end
    end

    resources :invoices
    resources :schedules

    collection do
      get 'search', action: :search, as: :search
    end

    member do
      get 'available'   , action: :available   , as: :available
      get 'unavailable' , action: :unavailable , as: :unavailable
      get '/:id/about'  , action: :about       , as: :about
    end
  end

  resource :customer_service_representative
  resource :accountant

  resources :orders do
    collection do
      post 'paypal', action: :paypal, as: :paypal
    end
  end
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

  resources :subscribers

  post "/paypal/callback" , to: "paypal#callback" , as: "paypal_callback"
  post "/paypal/success"  , to: "paypal#success"  , as: "paypal_success"
  get  "/paypal/cancel"   , to: "paypal#cancel"   , as: "paypal_cancel"

  get "/dashboard", to: "home#show", as: "dashboard"
  get "/unsubscribe/:id", to: "unsubscribe#unsubscribe", as: "unsubscribe"

  get "/email_confirmation", to: "home#confirmation", as: "email_confirmation"
  get "/apna", to: "home#apna", as: "apna"
  root to: 'home#index'
end
