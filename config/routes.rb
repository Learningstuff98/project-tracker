Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  patch 'projects/:project_id/issues/:id/move_issue', to: 'issues#move_issue', as: 'project_issue_move_issue'
  resources :projects do
    resources :issues, only: [:destroy, :edit, :update]
    resources :stages do
      resources :issues, only: [:new, :create]
    end
  end
  resources :issues, only: [:show]
end
