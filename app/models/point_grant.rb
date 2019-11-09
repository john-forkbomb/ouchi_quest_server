# frozen_string_literal: true

class PointGrant < ApplicationRecord
  belongs_to :parent
  belongs_to :child
end
