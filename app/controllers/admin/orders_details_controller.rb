class Admin::OrdersDetailsController < ApplicationController
  # アクセス権限
  before_action :authenticate_admin!
  
  def update
  end
end
