# frozen_string_literal: true

class RewardAcquisition < ApplicationRecord
  belongs_to :parent
  belongs_to :child
end
