Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/users", to: "users#index"
  get "/user", to: "users#show"
  get "/admin/user", to: "users#admin_show"
end
