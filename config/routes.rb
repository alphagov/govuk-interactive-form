Rails.application.routes.draw do
  get "/:items" => "items#index"
  resources :answers, only: [:create]
  get "/healthcheck", to: proc { [200, {}, %w(OK)] }
end
