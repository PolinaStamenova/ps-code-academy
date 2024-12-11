Rails.application.routes.draw do
  devise_for :users

  root to: redirect("/dashboard")
  get '/dashboard', to: 'dashboard#index', as: :dashboard

  namespace :admin do
    root to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :courses do
      resources :course_modules
    end
  end
end
