class User < ApplicationRecord
  has_secure_password
  validates :user,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  scope :recent, -> { order(created_at: :desc) }
  before_destroy :do_not_destroy_admin_user
  before_update :edit_destroy_admin_user

  private

  def do_not_destroy_admin_user
    if admin && User.where(admin: true).count <=1
      throw(:abort)
    end
  end

  def edit_destroy_admin_user
    throw :abort if (self.admin == false && User.where(admin: true).count == 1) && self == User.find_by(admin: true)
  end
end
