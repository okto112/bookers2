class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def check_login_status
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
