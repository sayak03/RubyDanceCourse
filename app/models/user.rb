class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]
  validates :first_name, :username, presence: true, uniqueness: true
  validates :contact_number, presence: true, length: { minimum: 10, maximum: 10}
  validates :last_name, presence: true

  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    elsif conditions.has_key?(:username)||conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
