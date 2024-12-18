Rails.application.routes.draw do
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
  
  devise_for :users

  root to: redirect("/dashboard")
  get '/dashboard', to: 'dashboard#index', as: :dashboard

  namespace :admin do
    root to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :courses do
      resources :course_modules do
        resources :module_lessons
      end
    end
  end
end
