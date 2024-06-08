# frozen_string_literal: true

module Entities
  class User < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'ID attribute of the User' }
    expose :group_id, documentation: { type: 'Integer', desc: 'ID attribute of the Group this User belongs to' }
    expose :email, documentation: { type: 'String', desc: 'Email attribute of the User' }
    expose :start_date_bucket, documentation: { type: 'Date', desc: 'Starting bucket date for User' }
    expose :end_date_bucket, documentation: { type: 'Date', desc: 'Ending bucket date for User' }
    expose :created_at, documentation: { type: 'String', desc: 'Date when attribute of the User was created' }
    expose :updated_at, documentation: { type: 'String', desc: 'Date when attribute of the User was updated' }
  end
end
