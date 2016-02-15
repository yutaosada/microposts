class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcom to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Edit your profile."
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :age, :location, :password, :password_confirmation)
  end
end
