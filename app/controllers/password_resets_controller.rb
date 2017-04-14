class PasswordResetsController < ApplicationController

	skip_before_action :require_login

  # User fills reset password form and submits it
  def create
    @user = User.find_by_email(params[:email])

    # Sends an email to the user with instructions on how to reset password (a url with a random token)
    @user.deliver_reset_password_instructions! if @user

    # Tells the user that instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    redirect_to(login_path, :notice => 'Instructions have been sent to your email.')
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  # This action fires when the user changes the password
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      redirect_to(login_path, :notice => 'Password was successfully updated.')
    else
      render :action => "edit"
    end
  end
end

