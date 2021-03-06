Dymo::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "visits#index"

  devise_for :users

  get 'reports/index'
  get 'reports/test_statistic'
  get 'reports/summary'
  #get 'reports/migrate_physicians'
  get 'reports/physician_patients'
  get 'reports/peak_time'

  resources :locations do
    resources :tokens, except: [:edit, :update] do
      resources :token_histories, except: [:edit, :update]
      member do
        post :done
        post :discard
      end
    end
  end

  resources :visits, only: [:index, :destroy]
  resources :physicians
  resources :test_groups
  resources :tests
  resources :app_configs

  resources :patients, except: [:index, :destroy] do
    resources :visits, only: [:new, :create, :edit, :update]
  end

end
