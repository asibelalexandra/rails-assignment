class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create

    form_email = params[:session][:email]
    form_password = params[:session][:password]

    user = User.find_by(email: form_email.downcase)
    if user&.authenticate(form_password)
      reset_session
      log_in user
      redirect_to root_path
      flash[:success] = 'Successfully logged in.'
    else
      flash.now[:danger] = 'Invalid email/password.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
    flash[:success] = 'Successfully logged out.'
  end

end
