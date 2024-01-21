class SearchController < ApplicationController
  def suggest
    query = params[:q]
    results = Item.where("name LIKE ?", "%#{query}%").limit(5)
    render json: results.map(&:name)
  end
end
