# frozen_string_literal: true

module Entities
  class User < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'ID attribute of the User' }
    expose :group_id, documentation: { type: 'Integer', desc: 'ID attribute of the Group this User belongs to' }
    expose :first_name, documentation: { type: 'String', desc: 'First name attribute of the User' }
    expose :last_name, documentation: { type: 'String', desc: 'Last name attribute of the User' }
    expose :email, documentation: { type: 'String', desc: 'Email attribute of the User' }
    expose :admin, documentation: { type: 'Boolean', desc: 'Boolean attribute of the User that determines if is an Admin or not' }
    expose :created_at, documentation: { type: 'String', desc: 'Date when attribute of the User was created' }
    expose :updated_at, documentation: { type: 'String', desc: 'Date when attribute of the User was updated' }
  end
end
