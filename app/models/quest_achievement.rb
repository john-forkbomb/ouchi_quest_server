# frozen_string_literal: true

class QuestAchievement < ApplicationRecord
  belongs_to :parent
  belongs_to :child
end
