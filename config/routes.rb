Rails.application.routes.draw do
  root 'home#show', event: 'cndt2020'
  get '/home#show' => redirect('/cndt2020')

  # Auth
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get 'logout' => 'logout#logout'

  # Admin
  get 'admin' => 'admin#show'
  get 'admin/accesslog' => 'admin#accesslog'
  get 'admin/users' => 'admin#users'
  get 'admin/talks' => 'admin#talks'
  post 'admin/bulk_insert_talks' => 'admin#bulk_insert_talks'
  get 'admin/speakers' => 'admin#speakers'
  post 'admin/bulk_insert_speakers' => 'admin#bulk_insert_speakers'
  post 'admin/bulk_insert_talks_speaker' => 'admin#bulk_insert_talks_speaker'
  delete 'admin/destroy_user' => 'admin#destroy_user'

  scope ":event" do
    resources :speakers, only: [:index, :show]
    resources :talks, only: [:show]
    get 'timetables' => 'timetable#index'
    get 'timetables/:date' => 'timetable#index'
    resources :track, only: [:show]
    get 'dashboard/show'
    get 'registration' => 'profiles#new'
    get '/' => 'event#show'

    # Profile
    resources :profiles, only: [:new, :edit, :update, :destroy, :create]
    get 'profiles/new', to: 'profiles#new'
    post 'profiles', to: 'profiles#create'
    put 'profiles', to: 'profiles#update'
    delete 'profiles', to: 'profiles#destroy'
    get 'profiles', to: 'profiles#edit'
    get 'profiles/edit', to: 'profiles#edit'

    namespace :profiles do
      get 'talks', to: 'talks#show'
      post 'talks', to: 'talks#create'
    end
    delete 'profiles/:id', to: 'profiles#destroy_id'
    put 'profiles/:id/role', to: 'profiles#set_role'
  end

  get '*path', controller: 'application', action: 'render_404'
end