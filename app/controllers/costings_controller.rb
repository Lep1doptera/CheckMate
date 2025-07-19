class CostingsController < ApplicationController
  before_action :set_costing, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @costings = current_user.costings.order(date: :desc)
  end

  def new
    @costing = current_user.costings.build
  end

  def create
    @costing = current_user.costings.build(costing_params)
    @costing.household = current_user.household

    if @costing.save
      redirect_to my_dashboard_path, notice: 'Costing was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @costing.update(costing_params)
      redirect_to my_dashboard_path , notice: 'Costing was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @costing.destroy
    redirect_to my_dashboard_path, notice: 'Costing was successfully deleted.'
  end

  private

  def set_costing
    @costing = current_user.costings.find(params[:id])
  end

  def costing_params
    params.require(:costing).permit(:title, :description, :date, :amount)
  end
end
