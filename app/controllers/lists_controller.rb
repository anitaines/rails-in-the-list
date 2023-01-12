class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # READ (ALL)
  def index
    # @lists = List.all
    @lists = policy_scope(List)
    @invitation = Invitation.new
    @item = Item.new
  end

  # READ (ONE)
  def show
    # @list = List.find(params[:id])
    authorize @list

    @item = Item.new

    @invitation = Invitation.new
  end

  # CREATE - STEP 1, GET THE FORM
  def new
    @list = List.new # Needed to instantiate the form_with
    authorize @list
  end

  # CREATE - STEP 2, POST THE FORM
  def create
    @list = List.new(list_params)
    authorize @list

    if @list.save
      @user_list = UserList.new(user: current_user, list: @list, admin: true)
      @user_list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # UPDATE - STEP 1, GET THE FORM (pre-filled with list attributes) for editing
  def edit
    # @list = List.find(params[:id])
    authorize @list
  end

  # UPDATE - STEP 2, PATCH THE FORM
  def update
    # @list = List.find(params[:id])
    authorize @list

    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    # @list = List.find(params[:id])
    authorize @list

    @list.destroy

    redirect_to user_root_path, status: :see_other
    # status: :see_other responds with a 303 HTTP status code
  end

  private

  def list_params
    params.require(:list).permit(:name, :comment, :image) # :latitude, :longitude,
  end

  def set_list
    @list = List.find(params[:id])
  end

end
