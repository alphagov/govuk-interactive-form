Rails.application.routes.draw do
  get ":items" => "items#start_page"
  get ":items/items" => "items#index", as: :items
  resources :selected_answers, only: [:create]
  resources :user_feedbacks, only: [:create]
  get "/healthcheck", to: proc { [200, {}, %w(OK)] }
end
