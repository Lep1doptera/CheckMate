class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user || user.first
    @household = @user.household
    @chores = @household ? @household.chores.order(:date_to_be_completed) : []
    @chore_status_data = [
      ['Complete', Chore.where(completed: true).count],
      ['Incomplete', Chore.where(completed: false).count]
    ]
  end

  def my_dashboard
    @user = current_user
    @household = @user.household
    @chores = @household.chores.where(user_id: @user.id)
  end
end
