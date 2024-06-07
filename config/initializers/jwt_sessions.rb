# frozen_string_literal: true

JWTSessions.algorithm = ENV['JWT_SIGNING_ALGORITHM']
JWTSessions.signing_key = ENV['JWT_SIGNING_KEY']