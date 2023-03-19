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

      @invitation = Invitation.new

      respond_to do |format|
        format.html { redirect_to lists_path }
        format.text { render partial: "lists/card", locals: { list: @list, invitation: @invitation, item: @item }, formats: [:html] }
      end

    elsif params[:origin] == "list-tab"

      respond_to do |format|
        if @item.save
          format.html { redirect_to list_path(@list) }
        else
          format.html { render "lists/show", status: :unprocessable_entity }
        end
        format.json { render template: "items/create" }
      end

    elsif params[:origin] == "usual-items-tab"

      @item.active = false

      respond_to do |format|
        if @item.save
          format.html { redirect_to list_path(@list) }
        else
          format.html { render "lists/show", status: :unprocessable_entity }
        end
        format.json { render template: "items/create_usual_item" }
      end

    end
  end

  def update
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
      format.json
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
