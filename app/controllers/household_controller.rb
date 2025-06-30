class HouseholdController < ApplicationController
  def invite_member
    User.invite!(
      email: params[:email],
      household: current_user.household
    )
  redirect_to household_path(current_user.household), notice: "Invite sent!"
  end
end
