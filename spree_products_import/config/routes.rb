Spree::Core::Engine.add_routes do
  # Add your extension routes here
  Spree::Core::Engine.routes.draw do
    namespace :admin, path: Spree.admin_path do
      resources :products do
        collection do
          post :batch_upload
        end
      end
    end
  end
end
