class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user || user.first
    @household = @user.household
    @chores = @household ? @household.chores.order(:date_to_be_completed) : []
  end

end
