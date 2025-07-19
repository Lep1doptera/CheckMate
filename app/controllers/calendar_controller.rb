class CalendarController < ApplicationController
 before_action :authenticate_user!

  def index
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today

    # ✅ CHANGED: Added nil check for household
    if current_user.household.present?
      @chores = current_user.household.chores.where(
        date_to_be_completed: @start_date.beginning_of_month.beginning_of_week..
                              @start_date.end_of_month.end_of_week
      )
    else
      @chores = Chore.none # ✅ CHANGED: Use empty relation instead of crashing
    end
  end
end
