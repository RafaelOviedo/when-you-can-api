# frozen_string_literal: true

module Entities
  class Group < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'ID attribute of the Group' }
    expose :name, documentation: { type: 'String', desc: 'Name of the Group' }
    expose :start_date_bucket_match, documentation: { type: 'Date', desc: 'First day of availability in the Group bucket' }
    expose :end_date_bucket_match, documentation: { type: 'Date', desc: 'Last day of availability in the Group bucket' }
    expose :members, using: Entities::User, documentation: { type: 'Array', desc: 'Members of the Group' }
  end
end
