# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }

  has_secure_password

  scope :with_first_name, ->(first_name) { where('users.first_name ILIKE ?', "%#{first_name}%") }
  scope :with_last_name, ->(last_name) { where('users.last_name ILIKE ?', "%#{last_name}%") }
  scope :with_email, ->(email) { where('users.email ILIKE ?', "%#{email}%") }
  scope :with_admin, ->(is_admin) { where({ users: { admin: is_admin } }) }
end
