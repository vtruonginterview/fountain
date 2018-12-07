class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      employer = Employer.find_by_user_id(user.id)
      if !employer.nil?
        redirect_to "/employer_job_postings"
      else
        redirect_to '/job_postings'
      end
    else
      flash[:notice] = 'Invalid Username or Password'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully Logged Out!'
    redirect_to '/login'
  end
end
