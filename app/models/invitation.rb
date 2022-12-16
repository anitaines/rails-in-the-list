class Invitation < ApplicationRecord
  belongs_to :list
  belongs_to :invitation_from, class_name: 'User', foreign_key: :invitation_from_id, required: true
  belongs_to :invitation_to, class_name: 'User', foreign_key: :invitation_to_id, required: true

  validates :message, length: { maximum: 255 }
end
