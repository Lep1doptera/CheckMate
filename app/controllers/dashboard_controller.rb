class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_week

  def index
    @user = current_user || user.first
    @household = @user.household
    @household_users = current_user.household.users
    household_cost = Costing.where(household: current_user.household)
    @user_weekly_spending = @household_users.map do |user|
      total = user.costings.where(date: @start_of_week..@end_of_week).sum(:amount)
      total
    end


    @chores = @household ? @household.chores.order(:date_to_be_completed) : []
    @chore_status_data = [
      ['Complete', Chore.where(completed: true).count],
      ['Incomplete', Chore.where(completed: false).count]
    ]
  end

  def my_dashboard
      @user = current_user
      @household = @user.household

      all_costings = current_user.costings.order(date: :desc)
      @costings = all_costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }

      @weekly_costings = @costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }
      @weekly_total = @weekly_costings.sum(&:amount)

      @chores = @household ? @household.chores.where(user_id: @user.id) : []
    end

    def set_week
      selected_date = params[:week].present? ? Date.parse(params[:week]) : Date.current
      @start_of_week = selected_date.beginning_of_week(:monday)
      @end_of_week = selected_date.end_of_week(:monday)
    end
end
