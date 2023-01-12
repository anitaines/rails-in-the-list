class List < ApplicationRecord
  has_one_attached :image
  has_many :user_lists, dependent: :destroy # List.find(id).user_lists
  has_many :users, -> { order(first_name: :asc) }, through: :user_lists # List.find(id).users
  has_many :items, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :invitations, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :comment, length: { maximum: 255 }
  validate :image_size_validation

  def image_size_validation
    if image.attached?
      errors.add(:image, ' should be less than 1MB') if image.byte_size > 1048576
      errors.add(:image, ' format should be jpeg, jpg or png') if !image.content_type.in?(%w[image/jpeg image/jpg image/png])
      # raise
    end
  end
end
