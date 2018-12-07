class ApplicationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Application.create(job_posting_id: params[:job_posting_id], user_id: session[:user_id])
    redirect_to '/job_postings'
  end
end
