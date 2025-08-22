Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  root "static_pages#top"
  resources :fragrances
  resources :calendars
  resources :reviews do
    resources :favorites, only: %i[create destroy]
    resources :comments, only: %i[create destroy edit update], shallow: true
  end
  resource :diagnosis, only: %i[new create ] do
    get :result
  end

  # プロフィールページ（お気に入り一覧も表示）
  resource :profile, only: %i[show edit update] do
    collection do
      get :favorites
    end
  end

  get "/health", to: "application#health"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # 利用規約とプライバシーポリシー
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"
end
