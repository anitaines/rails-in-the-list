class UserListsController < ApplicationController

  def destroy
    @user_list = UserList.find(params[:id])

    @list = @user_list.list

    authorize @user_list

    @user_list.destroy

    if @user_list.user == current_user # => user is exiting the list
      respond_to do |format|
        format.html { redirect_to user_root_path, status: :see_other }
        # format.text { render partial: "lists/users", locals: { list: @list, invitation: @invitation }, formats: [:html] }
        format.json { render json: { redirect: true } } # json version
      end
    else # => user is removing other user from the list
      respond_to do |format|
        format.html { redirect_to list_path(@list), status: :see_other }
        # format.text { render partial: "lists/users", locals: { list: @list, invitation: @invitation }, formats: [:html] }
        format.json { render json: { redirect: false } } # json version
      end
    end
  end
end
