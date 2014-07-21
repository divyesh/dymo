Dymo::Application.routes.draw do

  devise_for :users

  root to: "visits#index"

  get 'reports/index'

  resources :tokens, except: [:edit, :update] do
    resources :token_histories, except: [:edit, :update]
    member do
      post :done
      post :discard
    end
  end

  resources :visits, only: [:index, :destroy]
  resources :physicians
  resources :patients, except: [:index, :destroy] do
    resources :visits, only: [:new, :create, :edit, :update]
  end
  resources :tests
end
