class ChoresController < ApplicationController
  before_action :chore_find, only: [:edit, :destroy]

  def index
    @chores = Chore.all
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(chore_params)
    @chore.user = current_user
    @chore.household = current_user.household

    if @chore.save
      redirect_to chores_path, notice: "Chore was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
   @chore = Chore.find(params[:id])
  end

  def update
    if @chore.update(chore_params)
      redirect_to chores_path, notice: "Successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chore.destroy
    redirect_to chores_path, notice: "Chore deleted successfully."
  end


  private

  def chore_find
     @chore = Chore.find(params[:id])
  end

  def chore_params
    params.require(:chore).permit(:name, :description, :date_to_be_completed)
  end
end
