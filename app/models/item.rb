# require_relative "../../lib/humanize_date.rb"

class Item < ApplicationRecord
  include HumanizeDate

  scope :with_active_status, -> { where("active = true") }
  scope :done, -> { where("purchased = true") }

  belongs_to :list
  belongs_to :user, optional: true

  before_save :capitalize_name, if: -> { name_changed? }

  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :amount, length: { maximum: 55 }
  validates :comment, length: { maximum: 255 }

  def purchased_date_humanized
    # pretty(self.purchased_date.getlocal)
    pretty(self.purchased_date)
  end

  def capitalize_name
    self.name = name.capitalize
  end
end
