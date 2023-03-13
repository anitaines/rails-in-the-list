class ItemsController < ApplicationController

  def create
    @item = Item.new(item_params)
    @list = List.find(params[:list_id])
    @item.list = @list

    authorize @item

    if params[:origin] == "dashboard"

      if @item.save
        @item = Item.new
      end

      # @user_list = UserList.where(user: current_user, list: @list).first
      @invitation = Invitation.new

      respond_to do |format|
        format.html { redirect_to lists_path }
        format.text { render partial: "lists/card", locals: { list: @list, invitation: @invitation, item: @item }, formats: [:html] }
      end

    elsif params[:origin] == "list"

      respond_to do |format|
        format.html { redirect_to list_path(@list) }

        if @item.save
          format.text { render partial: "items/new_item_result", locals: { list: @list, item: @item, new_item: Item.new }, formats: [:html] }
        else
          format.text { render partial: "items/new_item", locals: { list: @list, item: @item }, formats: [:html] }
        end
      end

    elsif params[:origin] == "usual-items-tab"

      @item.active = false

      respond_to do |format|
        format.html { redirect_to list_path(@list) }

        if @item.save
          format.text { render partial: "items/new_usual_item_result", locals: { list: @list, item: @item, new_item: Item.new }, formats: [:html] }
        else
          format.text { render partial: "items/new_usual_item", locals: { list: @list, item: @item }, formats: [:html] }
        end
      end

    end

  end

  def update
    # params["item"][:purchased]
    # item_params[:purchased]
    # purchased checked   "purchased"=>"1", "name"=>"item to list id 11", "amount"=>"1", "comment"=>"??"}, "commit"=>"Update Item", "id"=>"3"
    # purchased UNchecked "purchased"=>"0", "name"=>"item to list id 11", "amount"=>"1", "comment"=>"??"}, "commit"=>"Update Item", "id"=>"3"
    # purchased no info   "purchased"=>"0", "name"=>"",                   "amount"=>"",  "comment"=>""},   "commit"=>"Update Item", "id"=>"3"

    @item = Item.find(params[:id])

    authorize @item

    if item_params[:purchased] == '1'
      unless @item.user == current_user
        @item.user = current_user
        @item.purchased_date = DateTime.now
      end
    else
      @item.user = nil
      @item.purchased_date = nil
    end

    if item_params[:active] == '0'
      params["item"][:purchased] = false
      @item.user = nil
      @item.purchased_date = nil
    end

    @list = @item.list

    @item.update(item_params)

    respond_to do |format|
      format.html { redirect_to list_path(@list) }
      if params[:origin] == "list-tab"
        format.text { render partial: "items/item", locals: { item: @item }, formats: [:html] }
      elsif params[:origin] == "usual-items-tab"
        format.text { render partial: "items/usual_item", locals: { item: @item }, formats: [:html] }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])

    @list = @item.list

    authorize @item

    @item.destroy

    respond_to do |format|
      format.html { redirect_to list_path(@list), status: :see_other }
      format.json { render json: { item: 'deleted' } } # json version
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :amount, :comment, :purchased, :active)
  end
end
