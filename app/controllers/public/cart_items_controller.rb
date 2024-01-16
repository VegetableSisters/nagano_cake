class Public::CartItemsController < ApplicationController
  # アクセス権限
  before_action :authenticate_customer!
  
  def index
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end
end
