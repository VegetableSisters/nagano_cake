class Admin::OrdersController < ApplicationController
  # アクセス権限
  before_action :authenticate_admin!
  
  def show
  end

  def update
  end
end
