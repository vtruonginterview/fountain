class JobPosting < ActiveRecord::Base
  belongs_to :employer
  has_many :applications

  enum status: [:active, :inactive]
end
