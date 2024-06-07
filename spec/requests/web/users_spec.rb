# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::UsersAPI, type: :request do
  let(:request_type) { :json }
  let!(:user) { create(:user, admin: true) }
  let!(:user2) { create(:user, first_name: 'Elliot', last_name: 'Alderson', email: 'elliot@fsociety.com') }
  let(:response_body) { response.parsed_body }
  let(:user_params) do
    {
      first_name: 'new user first name',
      last_name: 'new user last name',
      email: 'new@mail.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end
  let(:invalid_params) { 'some invalid params' }
  subject { response }

  describe 'GET /web/v1/users' do
    before do
      get '/web/v1/users', as: request_type
    end

    context 'with different request types' do
      context 'when request type is JSON' do
        it { is_expected.to be_successful }
        it 'returns JSON content type' do
          expect(subject.content_type).to eq(Helpers::Base.json_content_type)
        end

        it 'returns a list of all Users' do
          expect(subject.body).to eq([Entities::User.represent(user), Entities::User.represent(user2)].to_json)
        end
      end

      context 'when request type is Text' do
        let(:request_type) { :txt }
        it { is_expected.to be_successful }
        it 'returns JSON content type' do
          expect(subject.content_type).to eq(Helpers::Base.text_content_type)
        end
      end

      context 'when there are filter applied on request' do
        it 'responds with the correct value when filtering on first name' do
          get '/web/v1/users?first_name=Elliot', as: request_type
          expect(response_body.count).to eq(1)
          expect(response_body.first['id']).to eq(user2.id)
        end

        it 'responds with the correct value when filtering on last name' do
          get '/web/v1/users?last_name=Alderson', as: request_type
          expect(response_body.count).to eq(1)
          expect(response_body.first['id']).to eq(user2.id)
        end

        it 'responds with the correct value when filtering on email' do
          get '/web/v1/users?email=elliot@fsociety.com', as: request_type
          expect(response_body.count).to eq(1)
          expect(response_body.first['id']).to eq(user2.id)
        end
        
        it 'reponds with the correct value when filtering on admin' do
          get '/web/v1/users?admin=true', as: request_type
          expect(response_body.count).to eq(1)
          expect(response_body.first['id']).to eq(user.id)
        end
      end
    end 
  end

  describe 'GET /web/v1/users/:id' do
    before do
      get "/web/v1/users/#{user.id}", as: request_type
    end

    it 'return a valid object' do
      expect(subject).to be_successful
      expect(response_body).to be_a(Hash)
      expect(subject.body).to eq(Entities::User.represent(user).to_json)
    end
  end

  describe 'POST /web/v1/users' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post '/web/v1/users', as: request_type, params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns a JSON response with the new User' do
        post '/web/v1/users', as: request_type, params: user_params
        expect(subject).to be_successful
        expect(subject).to have_http_status(201)
        expect(response_body['id']).to eq(User.last.id)
        expect(subject.content_type).to eq(Helpers::Base.json_content_type)
      end
    end
      
    context 'with invalid params' do
      it 'does not create a new User' do
        expect do
          post '/web/v1/users', as: request_type, params: invalid_params
        end.to change(User, :count).by(0)
      end

      it 'returns a JSON response with errors for the new User' do
        post '/web/v1/users', as: request_type, params: invalid_params
        expect(subject).to_not be_successful
        expect(subject).to have_http_status(400)
        expect(response_body).to have_key('error')
      end
    end
  end

  describe 'PATCH /web/v1/users/:id' do
    context 'with valid params' do
      it 'updates the attribute of the User' do
        new_user_name = 'new user first name'
        patch "/web/v1/users/#{user.id}", params: user_params, as: request_type
        user.reload
        expect(user.first_name).to eq(new_user_name)
      end

      it 'returns JSON response with the updated Product' do
        patch "/web/v1/users/#{user.id}", params: { first_name: user.first_name }, as: request_type
        expect(subject.body).to eq(Entities::User.represent(user).to_json)
        expect(subject).to have_http_status(200)
        expect(subject.content_type).to eq(Helpers::Base.json_content_type)
      end
    end
  end
end
