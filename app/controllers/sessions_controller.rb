class SessionsController < ApplicationController
  before_action :current_user_available, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user&.password?(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete :user_id
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def current_user_available
    return unless current_user

    redirect_to root_path
  end
end
