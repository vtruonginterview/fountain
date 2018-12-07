class JobPostingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @job_postings = JobPosting.includes(:employer, :applications).order(created_at: :desc)
    @job_applied_ids = Application.where(user_id: session[:user_id]).pluck(:job_posting_id)
  end

  def create
    employer = Employer.find_by_user_id(session['user_id'])
    if employer.nil?
      flash[:notice] = 'Forbidden Access!'
      session.destroy
      redirect_to '/login'
    end

    job_posting = JobPosting.create(employer: employer,
                                    title: params[:title],
                                    description: params[:description])
    redirect_to "/employer_job_posting/#{job_posting.id}"
  end
end
