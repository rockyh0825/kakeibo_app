Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :salaries, only: [:index, :edit, :show]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :outgos, only: [:new, :index, :edit, :show, :create, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
