class HouseholdsController < ApplicationController
  before_action :set_household

  def show
    respond_to do |format|
      format.turbo_stream { redirect_to household_path(@household), locals: { household: @household } }
      format.html { redirect_to dashboard_path }
    end
  end

  def edit
    respond_to do |format|
      format.html { render partial: "dashboard/edit_household", locals: { household: @household } }
      format.html { redirect_to dashboard_path }
    end
  end

  def update
    if @household.update(household_params)
      respond_to do |format|
        format.turbo_stream { redirect_to household_path(@household), locals: { household: @household } }
        format.html { redirect_to household_path(@household), notice: "Household updated." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render partial: "edit_household", locals: { household: @household }, formats: [:html] }
        format.html { render :edit }
      end
    end
  end

  def remove_member
    user = User.find(params[:user_id])
    user.update(household_id: nil)

    respond_to do |format|
      format.turbo_stream { render partial: "edit_household", locals: { household: @household } }
      format.html { redirect_to household_path(@household), notice: "#{user.name} was removed from the household." }
    end
  end

  def invite_member
    Rails.logger.debug "Inviting #{params[:email]}"
    puts "Inviting #{params[:email]}"

    User.invite!(
      email: params[:email],
      household: current_user.household
    )

    redirect_to household_path(current_user.household), notice: "Invite sent!"
  end

  def leave
    current_user.update(household_id: nil)
    redirect_to my_dashboard_path, notice: "You've left the household."
  end


  private

  def set_household
    @household = current_user.household
  end

  def household_params
    params.require(:household).permit(:name)
  end
end
