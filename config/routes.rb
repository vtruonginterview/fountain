Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # employer routes
  get '/employers/signup' => 'employers#new'
  post '/employers' => 'employers#create'
  get 'employer_job_postings' => 'employers#employer_job_postings'
  get 'employer_job_posting/:job_posting_id' => 'employers#employer_job_posting'

  resources :job_postings, only: [:index, :show, :create] do
  end

  post '/applications/:job_posting_id' => 'applications#create'

  # sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
end
