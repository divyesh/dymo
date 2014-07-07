Dymo::Application.routes.draw do
  get 'reports/index'

  root to: "visits#index"

  resources :tokens, except: [:edit, :update] do
    resources :token_histories, except: [:edit, :update]
    member do
      post :done
      post :discard
    end
  end

  resources :visits, only: [:index, :destroy]
  resources :physicians
  resources :patients, except: [:index, :destroy]
end
