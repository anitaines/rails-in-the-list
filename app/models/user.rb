class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :user_lists # User.find(id).user_lists
  has_many :lists, through: :user_lists # User.find(id).lists

  validates :first_name, presence: true
  validate :image_size_validation

  def image_size_validation
    if avatar.attached?
      errors.add(:avatar, ' should be less than 1MB') if avatar.byte_size > 1048576
      errors.add(:avatar, ' format should be jpeg, jpg or png') if !avatar.content_type.in?(%w[image/jpeg image/jpg image/png])
      # raise
    end
  end
end
