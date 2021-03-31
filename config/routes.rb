Rails.application.routes.draw do

  root 'static_pages#home'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :employee do
    resources :timesheet
  end
  resources :employer do
    resources :budget
  end
  resources :budget
  resources :timesheet do
    post '/approve', to: 'timesheet#approve' #controller: timesheet, functia: approve
    post '/unapprove', to: 'timesheet#unapprove' #controller: timesheet, functia: unapprove
  end
end
