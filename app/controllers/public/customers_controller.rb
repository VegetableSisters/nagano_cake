class Public::CustomersController < ApplicationController
  # アクセス権限
  before_action :authenticate_customer!
  
  def show
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def withdraw
  end
end
