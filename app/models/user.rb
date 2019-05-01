class User < ApplicationRecord
  has_secure_password
  validates :user,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  scope :recent, -> { order(created_at: :desc) }
end
