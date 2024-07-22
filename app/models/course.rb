class Course < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates :title, :description, presence: true
end
