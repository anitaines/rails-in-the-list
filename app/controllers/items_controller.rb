class ItemsController < ApplicationController

  def create
    @item = Item.new(item_params)
    @list = List.find(params[:list_id])
    @item.list = @list

    authorize @item

    if @item.save
      redirect_to list_path(@list) # ?
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])

    authorize @item

    @list = @item.list

    if @item.update(item_params)
      redirect_to list_path(@list) # ?
    else
      # @item = Item.new # without this line, render fails
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])

    @list = @item.list

    authorize @item

    @item.destroy

    redirect_to list_path(@list), status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :amount, :comment)
  end
end
