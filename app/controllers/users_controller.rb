class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
  end

  def edit
    @user = helpers.current_user
  end

  def update
    @user = helpers.current_user
    @user.first_name = update_params[:first_name]
    @user.last_name = update_params[:last_name]

    if @user.save
      redirect_to user_path(@user.id)
      #flash[:success] = "Vos informations ont bien été changées."
    else
      #flash[:danger] = "Erreur: " + @user.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
  end

  private

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
