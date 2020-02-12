class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    if (@user.authenticate(password))
      @user
    else
      nil
    end
  end

  def lower_case
    self.email.downcase!
  end

  before_save :lower_case
end
