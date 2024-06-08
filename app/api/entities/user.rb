# frozen_string_literal: true

module Entities
  class User < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'ID attribute of the User' }
    expose :group_id, documentation: { type: 'Integer', desc: 'ID attribute of the Group this User belongs to' }
    expose :email, documentation: { type: 'String', desc: 'Email attribute of the User' }
    expose :dates_bucket, documentation: { type: 'Array', desc: 'Dates bucket for User' }
    expose :created_at, documentation: { type: 'String', desc: 'Date when attribute of the User was created' }
    expose :updated_at, documentation: { type: 'String', desc: 'Date when attribute of the User was updated' }
  end
end
