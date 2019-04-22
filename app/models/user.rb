class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { within: 6..20 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, pwd)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(pwd)
      user
    else
      nil
    end

  end
end
