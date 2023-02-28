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
      @invitation = Invitation.new
      params[:invitation] = nil # avoid re-displaying current invitation_to in new rendered invitation
    end

    if params[:origin] == "dashboard"

      # @user_list = UserList.where(user: current_user, list: @list).first
      @item = Item.new

      respond_to do |format|
        format.html { redirect_to lists_path }
        format.text { render partial: "lists/card", locals: { list: @list, invitation: @invitation, item: @item }, formats: [:html] }
      end

    elsif params[:origin] == "list"

      respond_to do |format|
        format.html { redirect_to list_path(@list) }
        format.text { render partial: "lists/users", locals: { list: @list, invitation: @invitation }, formats: [:html] }
      end

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
    @list = @invitation.list

    authorize @invitation

    @invitation.destroy

    if params[:origin] == "dashboard"
      respond_to do |format|
        format.html { redirect_to lists_path, status: :see_other }
        format.json { render json: { invitation: 'deleted' } } # json version
      end
    elsif params[:origin] == "list"
      respond_to do |format|
        format.html { redirect_to list_path(@list), status: :see_other }
        format.json { render json: { invitation: 'deleted' } } # json version
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitation_to_id, :message)
  end
end
