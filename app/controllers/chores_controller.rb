class ChoresController < ApplicationController
  before_action :chore_find, only: [:edit, :destroy, :update]

  def index
    @chores = Chore.all
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(chore_params)
    @chore.user = nil
    @chore.household = current_user.household

    if @chore.save
      redirect_to dashboard_path, notice: "Chore was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    if @chore.update(chore_params_update)
      if chore_params_update.key?(:user_id)
        @chore.update(assigned: @chore.user_id.present?)
        redirect_to dashboard_path
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to dashboard_path, notice: "Successfully updated" }
        format.json { render json: @chore }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
    redirect_to my_dashboard_path
  end

  def destroy
    @chore.destroy
    redirect_to my_dashboard_path, notice: "Chore deleted successfully."
  end

  private

  def chore_find
    @chore = Chore.find(params[:id])
  end

  def chore_params
    params.require(:chore).permit(:name, :description, :date_to_be_completed)
  end

  def chore_params_update
    params.require(:chore).permit(
      :name,
      :description,
      :date_to_be_completed,
      :user_id,
      :completed,
      :completion_date
    )
  end
end
