class HouseholdsController < ApplicationController
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
    redirect_to dashboard_path, notice: "Youve left the household."
  end
end
