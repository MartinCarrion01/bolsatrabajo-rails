Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :companies, except: [:new, :edit] do 
    resources :jobs, only: [:create]
  end

  resources :jobs, only: [:index, :show, :update, :destroy]
  resources :applicants, except: [:new, :edit]
end
