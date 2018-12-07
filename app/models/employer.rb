class Employer < ActiveRecord::Base
  belongs_to :user
  has_many :job_postings
end
