class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def self.generate_employer(attributes)
    user = generate(attributes)
    ActiveRecord::Base.transaction do
      user.save!
      Employer.create!(name: attributes[:organization_name], user: user)
    end

    user
  end

  def self.generate_applicant(attributes)
    user = generate(attributes)
    user.save!
    user
  end

  def self.generate(attributes)
    User.new(
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      email: attributes[:email],
      password: attributes[:password],
      password_confirmation: attributes[:password_confirmation]
    )
  end
  private_class_method :generate
end
