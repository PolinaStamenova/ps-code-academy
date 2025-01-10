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
    get '/active_courses', to: 'courses#active', as: :active_courses
    get '/draft_courses', to: 'courses#draft', as: :draft_courses

    resources :courses, except: [:index] do
      member do
        post :publish
      end

      resources :course_modules do
        resources :module_lessons do
          member do
            get :preview
          end
        end
      end
    end
  end

  resources :courses, only: [:index, :show] do
    resources :course_modules, only: [:show] do
      resources :module_lessons, only: [:show]
    end
  end
end