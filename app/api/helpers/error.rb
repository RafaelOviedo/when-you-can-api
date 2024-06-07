# frozen_string_literal: true

module Helpers
  module Error
    extend Grape::API::Helpers

    # Raises a 422 "Unprocessable Entity" error response. This method processes
    # errors from the specified model and returns it in the response body.
    def model_error!(model)
      error!({ code: 422, message: 'Unprocessable Entity', errors: process_model_errors(model) }, 422)
    end

    def process_model_errors(model)
      model&.errors&.messages&.map do |key, messages|
        { field: key, errors: messages }
      end
    end
  end
end
