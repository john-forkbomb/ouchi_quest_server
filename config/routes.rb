Rails.application.routes.draw do
  devise_for :parents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :attachable do
    post :publish_policy, on: :collection
  end

  namespace :api do
    post '/register', to: 'authentication#register', as: :register
    post '/login', to: 'authentication#login', as: :login
    post '/add_device', to: 'authentication#add_device', as: :add_device
    delete '/logout', to: 'authentication#logout', as: :logout

    resources :parents, only: :update do
      get 'me', on: :collection
    end
    resources :children do
      get 'me', on: :collection
      put 'grant', on: :member
    end
    resources :quests do
      put 'approve', on: :member
    end
    resources :rewards do
      put 'approve', on: :member
    end
    resources :quest_achievements, only: :index
    resources :reward_acquisitions, only: :index
    resources :point_grants, only: :index

    resources :quests, only: :none, concerns: :attachable
    resources :rewards, only: :none, concerns: :attachable
    resources :parents, only: :none, concerns: :attachable
    resources :children, only: :none, concerns: :attachable
  end
end
