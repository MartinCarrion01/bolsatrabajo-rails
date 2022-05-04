Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :companies, except: [:new, :edit] do 
    resources :jobs, only: [:create]
  end
  resources :jobs, only: [:index, :show, :update, :destroy]
  resources :applicants, except: [:new, :edit]

  #rutas no REST
  post '/applicants/:id/apply_to/:job_id', to: 'applicants#apply_to'
  post '/jobs/:id/change_state/:applicant_id', to: 'jobs#change_state'
end
