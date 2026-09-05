class RazorpayService
  def initialize
    key_id = Rails.application.credentials.dig(:razorpay, :key_id)
    key_secret = Rails.application.credentials.dig(:razorpay, :key_secret)

    raise "Razorpay credentials are not configured" if key_id.blank? || key_secret.blank?

    Razorpay.setup(key_id, key_secret)
  end

  def create_order(amount:, receipt:)
    Razorpay::Order.create(
      amount: amount,
      currency: "INR",
      receipt: receipt,
      payment_capture: 1
    )
  end

  def verify_payment_signature(order_id, payment_id, signature)
    return false if order_id.blank? || payment_id.blank? || signature.blank?

    body = "#{order_id}|#{payment_id}"
    expected = OpenSSL::HMAC.hexdigest(
      "SHA256",
      Rails.application.credentials.dig(:razorpay, :key_secret),
      body
    )

    ActiveSupport::SecurityUtils.secure_compare(expected, signature)
  end
end
