# frozen_string_literal: true

class AuthAPI < Grape::API
  helpers ::Helpers::Authentication

  resources :auth do
    desc 'Authenticates a User.' do
      success [{ code: 200, model: Entities::AuthToken }]
      failure [[404, 'Not Found']]
    end
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post do
      auth_params = declared(params)
      user = User.find_by(email: auth_params[:email])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload)
  
      if user&.authenticate(auth_params[:password])
        present(authenticated_user(session, user))
      else
        error!('Not Found', 404)
      end
    end
  end

  resources :users do
    desc 'Returns the currently authenticated User' do
      success [{ model: Entities::User, code: 200 }]
    end
    get :profile do
      present current_user, with: Entities::User
    end
  end
end
