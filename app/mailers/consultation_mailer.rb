class ConsultationMailer < ApplicationMailer
  default from: -> { ENV.fetch("MAILER_FROM", "no-reply@example.com") }

  def new_consultation(consultation_request)
    @consultation = consultation_request

    mail(
      to: ENV.fetch("CONSULTATION_RECIPIENT", "admin@example.com"),
      subject: "New Consultation Request from #{@consultation.full_name}"
    )
  end
end
