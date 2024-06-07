# frozen_string_literal: true

module Helpers
  module Base
    # returns 'application/json' content type
    def self.json_content_type
      'application/json'
    end

    # returns 'text/plain' content type
    def self.text_content_type
      'text/plain'
    end
  end
end
