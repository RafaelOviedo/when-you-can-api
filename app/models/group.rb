# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :members, class_name: 'User', inverse_of: :group

  validates :name, presence: true, length: { minimum: 8 }

  scope :with_name, ->(name) { where('groups.name ILIKE ?', "%#{name}%") }
end
