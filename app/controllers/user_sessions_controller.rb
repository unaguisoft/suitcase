class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to([:root], notice: 'Login successful')
    else
      flash[:error] = 'Email or password are incorrect. Try again'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Logout successful'
  end
end
