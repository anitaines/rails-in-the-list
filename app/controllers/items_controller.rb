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
    params.require(:item).permit(:name, :amount, :comment, :purchased)
  end
end
