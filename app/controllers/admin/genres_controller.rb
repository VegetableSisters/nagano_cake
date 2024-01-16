class Admin::GenresController < ApplicationController
  # アクセス権限
  #before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genru_params)
    genre.save
    redirect_to admin_genres_path
  end

  def edit
  end

  def update
  end
end
