class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      render json: @user
    else
      render json: ["No user found"], status: 422
    end

  end

  def destroy
    if (!current_user)
      render json: ["404 page not found"], status: 404
    else
      logout
      render json: {}
    end
  end
end
