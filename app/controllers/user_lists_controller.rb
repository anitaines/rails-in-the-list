class UserListsController < ApplicationController
  # READ (ALL)
  def index
    @user_lists = UserList.all
  end
  
end
