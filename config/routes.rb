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
          post :unpublish
        end

      resources :course_modules, except: %i[index show] do
        resources :module_lessons do
          member do
            get :preview
          end
        end

        resources :assignments, only: %i[new create]
      end
    end
  end

  resources :purchases, only: [:create] do
    member do
      get :success
      get :cancel
    end
  end

  get '/enrolled_courses', to: 'courses#enrolled', as: :enrolled_courses
  
  resources :courses, only: %i[index show] do
    member do
      post :purchase
    end

    resources :course_modules, only: [:show] do
      resources :module_lessons, only: [:show]
    end
  end
end