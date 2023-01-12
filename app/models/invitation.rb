class Invitation < ApplicationRecord
  belongs_to :list
  belongs_to :invitation_from, class_name: 'User', foreign_key: :invitation_from_id, required: true
  belongs_to :invitation_to, class_name: 'User', foreign_key: :invitation_to_id, required: true

  # validates :invitation_to_id, presence: true
  validates_presence_of :invitation_to_id, message: ' - error: no user exists with this email'
  validates :message, length: { maximum: 255 }
  # validates :invitation_to_id, uniqueness: { scope: :list_id }
  validate :invitation_to_must_be_to_valid_user

  def invitation_to_must_be_to_valid_user
    # don't repeat invitation,
    errors.add(:invitation_to_id, '- User has a pending invitation already') if Invitation.where(list: list, invitation_to: invitation_to).first
    # don't invite users that are on the user_lists already,
    # don't invite self
    errors.add(:invitation_to_id, '- User is already part of the list') if UserList.where(list: list, user: invitation_to).first
  end
end
