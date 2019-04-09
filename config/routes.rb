Rails.application.routes.draw do
  get 'doses/index'
  get 'meal_plans/index'
  get 'meal_plans/show'
  get 'meal_plans/new'
  get 'meal_plans/create'
  get 'meals/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :meal_plans, only: [:index, :show, :new, :create] do
    resources :meals, only: [:show]
    resources :doses, only: [:index]
  end
end
