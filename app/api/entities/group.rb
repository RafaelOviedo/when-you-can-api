# frozen_string_literal: true

module Entities
  class Group < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'ID attribute of the Group' }
    expose :name, documentation: { type: 'String', desc: 'Name of the Group' }
    expose :dates_bucket_match, documentation: { type: 'Array', desc: 'Days dates of availability in the Group bucket' }
    expose :members, using: Entities::User, documentation: { type: 'Array', desc: 'Members of the Group' }
  end
end
