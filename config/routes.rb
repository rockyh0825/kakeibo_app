Rails.application.routes.draw do
  devise_scope :user do
    root "devise/sessions#new"
  end
  devise_for :users
  
  resources :salaries, only: [:index, :edit, :show, :create, :update, :destroy]
  resources :genres, only: [:create, :edit, :update, :destroy]
  post "outgos/ocr" => "outgos#ocr"
  resources :outgos, only: [:new, :index, :edit, :show, :create, :update, :destroy]
  post "foodstuffs/recognize" => "foodstuffs#recognize"
  post "foodstuffs/confirm" => "foodstuffs#confirm"
  resources :foodstuffs, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
