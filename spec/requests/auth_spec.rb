# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthAPI, type: :request do
  let(:request_type) { :json }
  let!(:user) { create(:user, email: 'some@mail.com') }
  let(:login_params) { { email: 'some@mail.com', password: 'foobar123' } }
  let(:invalid_params) { { email: 'some@mail.com', password: '' } }
  let(:params) { login_params }
  let(:response_body) { response.parsed_body }
  subject { response }

  describe 'POST /web/v1/auth' do
    before do
      post '/web/v1/auth', as: request_type, params: params
    end

    context 'with valid params' do
      it 'returns a valid JSON response with the jwt and user' do
        expect(subject).to be_successful
        expect(subject).to have_http_status(201)
        expect(response_body.count).to eq(2)
        expect(response_body['user']['id']).to eq(user.id)
      end
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      it 'returns 404 Not Found error' do
        expect(subject).to_not be_successful
        expect(subject).to have_http_status(404)
        expect(response_body).to have_key('error')
      end
    end
  end
end
