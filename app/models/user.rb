class User < ApplicationRecord
  belongs_to :actor, polymorphic: true, optional: true

  scope :employees, -> { where(role: 'employee') }
end
