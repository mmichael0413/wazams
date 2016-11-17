require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe '#create' do
    let(:phone) { Faker::PhoneNumber.cell_phone }
    let(:url) { Faker::Internet.url }

    it 'should call the TwilioClient send_message method and return no content' do
      sanitized_phone = phone.gsub(/[^\d]/, '')
      expect_any_instance_of(TwilioClient).to receive(:send_message).with(sanitized_phone, url)
      post :create, params: { phone: phone, url: url }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe '#search' do
    let(:results) {[ Faker::Internet.url, Faker::Internet.url, Faker::Internet.url ]}

    context 'when search params are present' do
      let(:search) { Faker::Hipster.word }

      it 'should call the Giphy search method and return an array of image urls' do
        expect(Giphy).to receive(:search).and_return(results)
        allow(results).to receive(:map).and_return(results)

        post :search, params: { search: search }, format: :json
        resp_body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(resp_body.size).to eq(results.size)
        expect(results).to include resp_body.first
      end
    end

    context 'when search params are missing' do
      it 'should not call the Giphy search method and should raise an error' do
        expect {
          expect(Giphy).not_to receive(:search)
          post :search, format: :json
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

end