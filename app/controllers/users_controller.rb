class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :description, :email, :password, :password_confirmation)
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Ton user a été ajouté !"
      log_in @user
      redirect_to gossips_path
    else
      flash[:danger] = "Ton user n'est pas valide !"
      render new_user_path
    end
  end
end
