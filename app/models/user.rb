class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_destroy :clean_user_records

  has_one_attached :avatar
  has_many :user_lists, dependent: :destroy # User.find(id).user_lists
  has_many :lists, through: :user_lists # User.find(id).lists

  has_many :invitations_from, class_name: 'Invitation', foreign_key: :invitation_from_id, dependent: :destroy
  has_many :invitations_to, class_name: 'Invitation', foreign_key: :invitation_to_id, dependent: :destroy

  validates :first_name, presence: true
  validate :image_size_validation

  def image_size_validation
    if avatar.attached?
      errors.add(:avatar, ' should be less than 1MB') if avatar.byte_size > 1048576
      errors.add(:avatar, ' format should be jpeg, jpg or png') if !avatar.content_type.in?(%w[image/jpeg image/jpg image/png])
      # raise
    end
  end

  private

  def clean_user_records
    done_items = Item.where(user: self)
    done_items.each do |item|
      item.user = nil
      item.purchased_date = nil
      item.purchased = false
      item.save
    end

    lists_created_by_user = UserList.where(user: self, admin: true)
    lists_created_by_user.each do |user_list|
      user_list.destroy
      user_list.list.destroy
    end
  end
end
