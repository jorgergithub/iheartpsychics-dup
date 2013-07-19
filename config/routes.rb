IHeartPsychics::Application.routes.draw do
  devise_for :users

  resources :calls do
    collection do
      post 'notify(:.format)'         , action: :notify
      get  'notify(:.format)'         , action: :notify
      post 'user(:.format)'           , action: :user
      post 'pin(:.format)'            , action: :pin
      post 'transfer(:.format)'       , action: :transfer
      post 'call_finished(:.format)'  , action: :call_finished
    end
  end

  resource :client do
    resources :client_phones, shallow: true
    member do
      get   'reset_pin(:.format)'     , action: :reset_pin, as: :reset_pin
      patch 'reset_pin(:.format)'     , action: :reset_pin
      get   'add_minutes(:.format)'   , action: :add_minutes, as: :add_minutes
      patch 'add_minutes(:.format)'   , action: :add_minutes
      get   'make_favorite(:.format)' , action: :make_favorite, as: :make_favorite
    end
  end

  resource :psychic

  root to: 'home#show'
end
