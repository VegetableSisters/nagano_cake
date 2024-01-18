class ApplicationController < ActionController::Base
  
  # 検索機能　Gem ransackより
before_action :set_search

def set_search
  @query = { title_or_content_cont: params[:q] }
  @search = Item.ransack(@query)
  # Gem kaminariでページネーション追加したら、page移行を追加
  # @search_items = @search.result.order(created_at: :desc).page(params[:page])
  @search_items = @search.result.order(created_at: :desc)
end
  
end
