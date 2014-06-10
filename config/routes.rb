class Spree::PossiblePage
  def self.matches?(request) 
    @locales ||= I18n.available_locales.map &:to_s
    components = request.path.gsub(/(^\/+)/, "").split('/')
    components.shift if @locales.include?(components.first)
    return false if components.first =~ /^(admin|account|cart|checkout|content|login|pg|orders|products|s|session|signup|shipments|states|t|tax_categories|user)$/
    path = components.join("/")
    !Spree::Page.active.find_by_path(path).nil?
  end
end

Spree::Core::Engine.routes.append do
  
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
  
  constraints(Spree::PossiblePage) do
    get '*page_path', :to => 'pages#show'#, :as => :page
  end
  
end
