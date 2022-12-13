class Item < ApplicationRecord
  belongs_to :list
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :amount, length: { maximum: 55 }
  validates :comment, length: { maximum: 255 }
end
