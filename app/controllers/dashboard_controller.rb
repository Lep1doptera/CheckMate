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
    @users = @household&.users || []

    if @household
      chores_this_week_to_be_completed = @household.chores.where(date_to_be_completed: @start_of_week..@end_of_week)
      chores_this_week_been_completed = @household.chores.where(completion_date: @start_of_week..@end_of_week)

      @overall_labels = ["Completed", "Incomplete"]
      @overall_data = [
        chores_this_week_been_completed.where(completed: true).count,
        chores_this_week_to_be_completed.where(completed: [false, nil]).count
      ]

      @user_labels = @users.map(&:name)
      @user_data = @users.map do |user|
        user.chores
            .where(completed: true)
            .where(completion_date: @start_of_week..@end_of_week)
            .count
      end
      else
        @overall_labels = []
        @overall_data = []
        @user_labels = []
        @user_data = []
    end
  end

  def my_dashboard
      @user = current_user
      @household = @user.household

      all_costings = current_user.costings.order(date: :desc)
      @costings = all_costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }

      @weekly_costings = @costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }
      @weekly_total = @weekly_costings.sum(&:amount)

      @chores = @household ? @household.chores.where(user_id: @user.id) : Chore.none
    end

    def set_week
      selected_date = params[:week].present? ? Date.parse(params[:week]) : Date.current
      @start_of_week = selected_date.beginning_of_week(:monday)
      @end_of_week = selected_date.end_of_week(:monday)
    end
end
