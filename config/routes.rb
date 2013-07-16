IHeartPsychics::Application.routes.draw do
  devise_for :users

  resources :calls do
    collection do
      post 'notify(:.format)', action: :notify
      get  'notify(:.format)', action: :notify
    end
  end
end
