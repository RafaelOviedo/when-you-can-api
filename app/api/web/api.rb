# frozen_string_literal: true

module Web
  class API < Grape::API
    version 'v1', using: :path, vendor: 'The Fetching Game'
    content_type :json, ::Helpers::Base.json_content_type
    content_type :txt, ::Helpers::Base.text_content_type
    default_format :json
    prefix :web

    mount(AuthAPI)
    mount(Web::UsersAPI)
    mount(Web::GroupsAPI)
  end
end
