Rails.application.routes.draw do
  get 'foodstuffs/index'
  root to: "homes#top"
  devise_for :users
  
  resources :salaries, only: [:index, :edit, :show, :create, :update, :destroy]
  resources :genres, only: [:index, :create, :edit, :update]
  post "outgos/ocr" => "outgos#ocr"
  resources :outgos, only: [:new, :index, :edit, :show, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
