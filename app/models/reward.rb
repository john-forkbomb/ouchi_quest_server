# frozen_string_literal: true

class Reward < ApplicationRecord
  extend Enumerize

  belongs_to :parent
  belongs_to :child

  enumerize :status, in: %i[none requested approved], default: :none

  validate :check_point

  def check_point
    return if (point % 50).zero? && point <= 10_000

    errors.add(:point, 'ポイントは50の倍数で, 10000ポイント以下設定する必要があります')
  end
end
