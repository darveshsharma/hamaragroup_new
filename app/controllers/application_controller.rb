class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_profile_completion, if: :user_signed_in?

  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[first_name last_name phone address]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[first_name last_name phone address]
    )
  end

  def require_active_member
    return if user_signed_in? && (current_user.active_member? || current_user.admin?)

    redirect_to new_membership_payment_path,
                alert: "Please become a member to access this page."
  end

  def check_profile_completion
    if current_user && !current_user.profile_completed? && !on_profile_edit_page?
      redirect_to edit_profile_path, alert: "Please complete your profile before continuing."
    end
  end

  def on_profile_edit_page?
    controller_name == "profiles" && action_name.in?(%w[edit update])
  end

  private

  def layout_by_resource
    "application"
  end
end
