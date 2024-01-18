class Public::AddressesController < ApplicationController
  # アクセス権限
  before_action :authenticate_customer!

  def index
    @addresses = Addresse.all
    @addresse = Addresse.new
  end

  def edit
  end

  def create
    addresse = Addresse.new(addresse_params)
    addresse.save
    redirect_to admin_genres_path
  end

  def update
  end

  def destroy
  end
end
