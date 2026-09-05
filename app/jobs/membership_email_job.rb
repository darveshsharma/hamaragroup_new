class MembershipEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, membership_payment_id)
    user = User.find_by(id: user_id)
    membership = MembershipPayment.find_by(id: membership_payment_id)
    return unless user && membership

    MembershipMailer.membership_confirmation(user, membership).deliver_now
  end
end
