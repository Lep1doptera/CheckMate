class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user || user.first
    @household = @user.household
    @chores = @household ? @household.chores.order(:date_to_be_completed) : []
    if @household
      @users = @household.users

      @overall_labels = ["Complete", "Incomplete"]
      @overall_data = [
        @household.chores.where(completed: true).count,
        @household.chores.where(completed: false).count
      ]

      @user_labels = @users.map(&:name)
      @user_data = @users.map { |user| user.chores.where(completed: true).count }
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
    if @household
      @chores = @household.chores.where(user_id: @user.id)
    else
      @chores = []
    end
    @chore_status_data = [
      ['Complete', @chores.where(completed: true).count],
      ['Incomplete', @chores.where(completed: false).count]
    ]
  end
end
