require 'rails_helper'

describe TwilioClient do

  describe '#send_message' do
    let(:url) { "https://api.twilio.com/2010-04-01/Accounts/#{ENV.fetch('TWILIO_ACCOUNT_SID')}/Messages.json" }
    let(:media_url) { Faker::Internet.url }
    let(:to) { Faker::PhoneNumber.cell_phone }
    let(:resp) { { status: 'queued' }.to_json }

    context 'with valid arguments' do
      it 'should send an SMS' do
        stub = stub_request(:post, url).to_return(body: resp, status: 200)
        expect{
          TwilioClient.new.send_message(to, media_url)
        }.not_to raise_error
        expect(stub).to have_been_requested
      end
    end

    context 'with invalid arguments' do
      it 'should raise an error' do
        stub = stub_request(:post, url)
        expect{
          TwilioClient.new.send_message('+12345', media_url)
        }.to raise_error StandardError
        expect(stub).to have_been_requested
      end
    end
  end

end