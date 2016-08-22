Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #this defines a route that when we receive a 'GET' request with URL '/' it will invoke the 'welcome_controller' with 'index' action.
  #this is called DSL: Domain Specific Language. It's just ruby written in a special way for special purpose (in this case for defining Routes)

  #we can use 'as:' option to set a custom named route path
  root 'welcome#index'
  get '/about' => 'welcome#about' #as: about_us
  get '/contact' => 'contact#new', as: :new_contact
  post '/contact' => 'contact#create', as: :contact

  resources :users, only: [:new, :create, :show, :edit, :update]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :questions do
    #collection is used when we don't need to specify a particular question, but we expect a collection of questions. Ex. index/create
    # post :search, on: :collection
    #member is used when we need to identify a particular question. Ex. show/edit/update/destory
    # post :search, on: :member
    #this is when we want to have nested routes for our resources. Ex. answers for questions.
    # post :search

    resources :answers, only: [:create, :destroy,:index]
  end

  # get '/questions/new' => "questions#new", as: :new_question
  # post '/questions' => "questions#create", as: :questions
  # get '/questions' => 'questions#index'
  # get '/questions/:id' => 'questions#show', as: :question
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  # patch '/questions/:id' => 'questions#update'
  # delete '/questions/:id' => 'questions#destroy'

end
