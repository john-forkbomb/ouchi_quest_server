# frozen_string_literal: true

class QuestSerializer < BaseSerializer
  attributes :title,
    :description,
    :point,
    :quest_type,
    :status,
    :period
    :image
end
