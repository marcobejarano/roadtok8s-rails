Rails.application.routes.draw do
  root "hello_rails#index"

  namespace :api do
    namespace :v1 do
      get "hello_k8s", to: "hello_k8s#welcome_to_k8s"
    end
  end
end
