class UsersController < ApplicationController
  def new
  end

  def create
    begin
      user = User.generate_applicant(params)
      redirect_to '/login'
    rescue Exception => e
      flash[:notice] = 'Something went wrong! Please try again!'
      redirect_to '/signup'
    end
  end
end
