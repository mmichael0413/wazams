class TwilioClient

  def initialize
    @client ||= Twilio::REST::Client.new(
      ENV.fetch('TWILIO_ACCOUNT_SID'),
      ENV.fetch('TWILIO_AUTH_TOKEN')
    )
  end

  def send_message(to, media_url)
    @client.account.messages.create({
      from: "#{ENV.fetch('TWILIO_FROM_NUMBER')}",
      to:   "+1#{to}",
      media_url: media_url
    })
  rescue => e
    raise StandardError.new(e)
  end

end