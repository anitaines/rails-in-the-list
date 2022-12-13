class UserListsController < ApplicationController
  def index
    # @user_lists = UserList.all
    @user_lists = policy_scope(UserList)
  end
end
