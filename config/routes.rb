IHeartPsychics::Application.routes.draw do
  devise_for :users

  resources :calls do
    collection do
      post 'notify(:.format)' , action: :notify
      get  'notify(:.format)' , action: :notify
      post 'user(:.format)'   , action: :user
      post 'pin(:.format)'    , action: :pin
    end
  end

  resource :clients do
    resource :phones, controller: 'client_phones' do
    end
  end

  root to: 'home#show'
end
