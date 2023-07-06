class CompensationRequest < ApplicationRecord
  extend Enumerize

  enumerize :currency, in: %w[USD EUR], default: 'USD'
  enumerize :status, in: %i[pending approved], default: :pending

  belongs_to :user
end