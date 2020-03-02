Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts, except: [:update, :edit, :new, :show] do
    member do
      get 'image'
      get 'download'
    end
  end
end
