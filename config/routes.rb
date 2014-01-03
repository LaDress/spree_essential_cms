class Spree::PossiblePage
  def possible_page?(request)
    non_page_routes = %w(admin account cart checkout content login pg/ orders products s/ session signup shipments states t/ tax_categories user)
    non_page_routes.none? { |path| request.path.include? path }
  end

  def matches?(request)
    possible_page?(request) && Spree::Page.active.find_by_path(request.path)
  end
end

Spree::Core::Engine.routes.draw do
  resources :pages
  namespace :admin do

    resources :pages, :constraints => { :id => /.*/ } do
      collection do
        post :update_positions
      end

      resources :contents do
        collection do
          post :update_positions
        end
      end

      resources :images, :controller => "page_images" do
        collection do
          post :update_positions
        end
      end
    end

  end
end

Spree::Core::Engine.routes.append do
  get ':page_path', :to => "pages#show", :as => :page, :constraints => Spree::PossiblePage.new
end
