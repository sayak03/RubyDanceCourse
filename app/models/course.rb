class Course < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true
end
