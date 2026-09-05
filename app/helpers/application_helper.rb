module ApplicationHelper
  def admin?
    user_signed_in? && current_user.role == 'admin'
  end

  def member?
    user_signed_in? && current_user.role == 'member'
  end

  def dealer?
    user_signed_in? && current_user.role == 'dealer'
  end
end
