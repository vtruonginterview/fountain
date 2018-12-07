class EmployersController < ApplicationController
  before_action :authenticate_employer, :only => [:employer_job_posting, :employer_job_postings]

  def new
  end

  def create
    begin
      user = User.generate_employer(params)
      employer = Employer.find_by_user_id(user.id)
      redirect_to "/login"
    rescue Exception => e
      flash[:notice] = 'Something went wrong! Please try again!'
      redirect_to '/employers/signup'
    end
  end

  def employer_job_postings
    @employer = Employer.find_by_user_id(session['user_id'])
    @job_postings = JobPosting.where(employer_id: @employer.id).order(created_at: :desc)
    @employer_id = @employer.id
  end

  def employer_job_posting
    begin
      @job_posting = JobPosting.where(employer_id: @employer.id, id: params[:job_posting_id]).first
      @applications = Application.includes(:user).where(job_posting_id: params[:job_posting_id]).order(created_at: :desc)
    rescue
      flash[:notice] = 'Something went wrong! Please try again!'
      redirect_to '/employer_job_postings'
    end
  end

  # TODO: move to concern
  def authenticate_employer
    @employer = Employer.find_by_user_id(session['user_id'])
    if @employer.nil?
      flash[:notice] = 'Forbidden Access!'
      session.destroy
      redirect_to '/login'
    end
  end
end
