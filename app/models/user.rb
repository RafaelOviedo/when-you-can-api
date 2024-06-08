# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :group, inverse_of: :members

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }, if: proc { |u| u.password.present? }
  validates :password_confirmation, presence: true, length: { minimum: 8 }, unless: proc { |u| u.password.blank? }

  has_secure_password

  scope :with_email, ->(email) { where('users.email ILIKE ?', "%#{email}%") }
  scope :with_admin, ->(is_admin) { where({ users: { admin: is_admin } }) }
end
