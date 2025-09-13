Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root "static_pages#top"
  resources :fragrances
  resources :calendars
  resources :reviews do
    resource :favorite, only: %i[create destroy]
    resources :comments, only: %i[create destroy edit update], shallow: true
    collection do
      get :autocomplete
    end
  end
  resource :diagnosis, only: %i[new create ] do
    get :result
  end

  resource :profile, only: %i[show edit update]
  get "profile/favorites", to: "profiles#favorites", as: "profile_favorites"

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

  # ブラウザ上で送信メールの履歴一覧を確認できるようにするための設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
