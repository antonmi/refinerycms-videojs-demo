Refinery::Core::Engine.routes.append do
  match '/system/videos/*dragonfly', :to => Dragonfly[:refinery_videos]

  # Frontend routes
  namespace :videos do
    resources :videos, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :videos, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :videos do
        collection do
          post :update_positions
          get :insert
          get :append_to_wym
        end
      end

      resources :video_sets do
        collection do
          post :update_positions
        end
      end
    end
  end

end
