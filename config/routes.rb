Rails.application.routes.draw do
  post 'submit', to: 'documents#submit'
  get 'search', to: 'documents#search'
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
