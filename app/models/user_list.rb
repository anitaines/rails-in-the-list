class UserList < ApplicationRecord
  belongs_to :user # UserList.find(id).user
  belongs_to :list # UserList.find(id).list
end
