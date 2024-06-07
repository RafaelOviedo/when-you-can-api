# frozen_string_literal: true

module Helpers
  module Authentication
    extend Grape::API::Helpers
    # returns a Hash with the jwt token and the user Entity
    def authenticated_user(session, user)
      { jwt: session.login[:access], user: Entities::User.represent(user) }
    end

    # Returns the currently logged in user.
    def current_user
      @current_user ||= fetch_user_from_token
    end

    private

    # Returns the user associated with the jwt authentication
    def fetch_user_from_token
      return unless token_payload

      User.find(token_payload[0]['user_id'])
    end

    # Returns the jwt
    def token_payload
      JWTSessions::Token.decode(authorization_token)
    rescue JWT::DecodeError
      nil
    end

    # Token from the Authorization header
    def authorization_token
      headers['Authorization'].presence
    end
  end
end
