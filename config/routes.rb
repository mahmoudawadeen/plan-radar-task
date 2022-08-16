Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      scope :news do
        post ':city/register', to: 'notification_registrations#upsert', as: :registration
        put ':city/register', to: 'notification_registrations#upsert'
        delete ':city/deregister/:id', to: 'notification_registrations#destroy', as: :deregistration
      end
    end
    scope :news do
      get ':city', to: 'news#get_by_city', as: :news
    end
  end
end
