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
      all_costings = current_user.costings.order(date: :desc)

      selected_date = params[:week].present? ? Date.parse(params[:week]) : Date.current
      @start_of_week = selected_date.beginning_of_week(:monday)
      @end_of_week = selected_date.end_of_week(:monday)

      @costings = all_costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }
      @weekly_total = @costings.sum(&:amount)

      @weekly_costings = @costings.select { |c| c.date && c.date >= @start_of_week && c.date <= @end_of_week }
      @weekly_total = @weekly_costings.sum(&:amount)

      @chores = @household ? @household.chores.where(user_id: @user.id) : []
      @chore_status_data = [
        ['Complete', @chores.where(completed: true).count],
        ['Incomplete', @chores.where(completed: false).count]
      ]
    end
end
