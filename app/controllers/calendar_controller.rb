class CalendarController < ApplicationController
 before_action :authenticate_user!

  def index
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today

    @chores = current_user.household.chores.where(
      date_to_be_completed: @start_date.beginning_of_month.beginning_of_week..
                            @start_date.end_of_month.end_of_week
    )
  end
end
