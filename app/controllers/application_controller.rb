class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    customers_show_path
  end

  before_action :set_search

  def set_search
    @query = { title_or_content_cont: params[:q] }
    @search = Item.ransack(@query)
    @search_items = @search.result.order(created_at: :desc)
  end
end
