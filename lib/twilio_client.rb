class TwilioClient

  def initialize
    @client ||= Twilio::REST::Client.new(
      ENV.fetch('TWILIO_ACCOUNT_SID'),
      ENV.fetch('TWILIO_AUTH_TOKEN')
    )
  end

  def send_sms(to, body)
    @client.account.messages.create({
      from: "#{ENV.fetch('TWILIO_FROM_NUMBER')}",
      to:   "+1#{to}",
      body: body
    })
  rescue => e
    raise StandardError.new(e)
  end

end