class MembershipMailer < ApplicationMailer
  default from: 'anamikakaushik269@gmail.com'

  def membership_confirmation(user, membership)
    @user = user
    @membership = membership
    mail(
      to: @user.email,
      subject: 'Membership Purchase Confirmation'
    )
  end
end
