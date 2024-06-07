# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Tyler' }
    last_name { 'Durden' }
    email { 'example@mail.com' }
    password { 'foobar123' }
    password_confirmation { 'foobar123' }
    admin { false }

    factory :admin_user do
      admin { true }
    end
  end
end
