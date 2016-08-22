class User < ApplicationRecord
  # has_secure password automatically adds attribute acessor for password and password_confirmation. Require bcrypt. Automatically hashes the password and stores it in the password_digest field.
  # if password_confirmation is provided then it makes sure it's the same as the password.
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: VALID_EMAIL_REGEX
  # attr_accessor :password, :password_confirmation

  has_many :questions, dependent: :nullify
  after_initialize :set_defaults

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  private

  def set_defaults
    self.admin ||= false
  end

end
