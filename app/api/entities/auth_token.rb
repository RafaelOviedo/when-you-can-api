# frozen_string_literal: true

module Entities
  class AuthToken < Grape::Entity
    expose :jwt, documentation: { type: 'String', example: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDczOTY2MzIsInN1YiI6MjA1ODd9.2ADmKQebcQRRF7Qsf9OUXGrmdKy1e_vHYc6Bc3kioDc', desc: 'JWT Token used to make authenticated requests' }
    expose :user, documentation: { type: Entities::User } do |instance, options|
      Entities::User.represent instance.user, shallow: true unless options[:shallow]
    end
  end
end
