class ConsultationRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_member
  before_action :set_property, only: %i[new create]

  def new
    @consultation_request = current_user.consultation_requests.build(
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      email: current_user.email,
      phone_number: current_user.phone
    )
  end

  def create
    @consultation_request = current_user.consultation_requests.build(consultation_request_params)
    @consultation_request.property = @property

    if @consultation_request.save
      ConsultationMailer.new_consultation(@consultation_request).deliver_later
      redirect_to new_consultation_request_path,
                  notice: "Your consultation inquiry has been sent successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_property
    @property = current_user.admin? ? Property.find_by(id: params[:property_id]) : Property.approved.find_by(id: params[:property_id])
  end

  def consultation_request_params
    params.require(:consultation_request).permit(
      :first_name, :last_name, :email, :phone_number, :message
    ).tap do |attributes|
      attributes[:description] = attributes.delete(:message)
      attributes[:full_name] = [attributes[:first_name], attributes[:last_name]].compact_blank.join(" ")
    end
  end
end
