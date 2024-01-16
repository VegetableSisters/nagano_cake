class Admin::GenresController < ApplicationController
  # アクセス権限
  before_action :authenticate_admin!
  
  def index
  end

  def create
  end

  def edit
  end

  def update
  end
end
