class List < ApplicationRecord
  has_one_attached :image
  has_many :user_lists # List.find(id).user_lists
  has_many :users, through: :user_lists # List.find(id).users

  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :comments, length: { maximum: 255 }
  validate :image_size_validation

  def image_size_validation
    if image.attached?
      errors.add(:image, ' should be less than 1MB') if image.byte_size > 1048576
      errors.add(:image, ' format should be jpeg, jpg or png') if !image.content_type.in?(%w[image/jpeg image/jpg image/png])
      # raise
    end
  end
end
