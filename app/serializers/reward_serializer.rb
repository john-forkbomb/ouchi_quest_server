# frozen_string_literal: true

class RewardSerializer < BaseSerializer
  attributes :name,
    :description,
    :point,
    :status,
    :image
end
