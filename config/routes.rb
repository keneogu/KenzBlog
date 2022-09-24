Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'search', to: "articles#search"
  resources :articles do
    resources :comments
  end
  root "articles#index"
end
