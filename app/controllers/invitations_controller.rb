class InvitationsController < ApplicationController
  
  def create
    @invitation = Invitation.new

    @list = List.find(params[:list_id])
    @invitation.list = @list

    @invitation.invitation_from = current_user

    @invitation.invitation_to = User.find_by(email: invitation_params[:invitation_to_id])

    @invitation.message = invitation_params[:message]

    authorize @invitation

    if @invitation.save
      redirect_to list_path(@list) # ?
    else
      @item = Item.new
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def accept
    @invitation = Invitation.find(params[:id])

    @user_list = UserList.new(user: @invitation.invitation_to, list: @invitation.list, admin: false)

    authorize @invitation, :destroy?

    if @user_list.save
      @invitation.destroy
      redirect_to list_path(@user_list.list) # ?
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    authorize @invitation

    @invitation.destroy

    redirect_to user_root_path, status: :see_other
    # status: :see_other responds with a 303 HTTP status code
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitation_to_id, :message)
  end
end
