class Spree::PagesController < Spree::BaseController
  include Spree::Core::ControllerHelpers::Order
  helper Spree::StoreHelper
  helper Spree::BaseHelper
  before_filter :load_page

  def show
    raise ActionController::RoutingError.new("No route matches [GET] #{request.path}") if @page.nil? 
    if @page.root?
      @posts    = Spree::Post.live.limit(5)    if SpreeEssentials.has?(:blog)
      @articles = Spree::Article.live.limit(5) if SpreeEssentials.has?(:news)
      render :template => 'spree/pages/home'
    end
  end

  private

  def load_page
    @page ||= Spree::Page.find_by_fuzzy_path(params[:page_path])
  end

  def accurate_title
    @page.meta_title
  end
end
