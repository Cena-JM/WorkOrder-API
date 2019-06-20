Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :assignments
      resources :work_orders
      resources :workers
    end
  end
end
