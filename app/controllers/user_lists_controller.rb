class UserListsController < ApplicationController
  # READ (ALL)
  def index
    # @user_lists = UserList.all
    @user_lists = policy_scope(UserList)
  end
  
end
