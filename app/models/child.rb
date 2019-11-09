# frozen_string_literal: true

class Child < ApplicationRecord

  belongs_to :parent

  has_many :quests
  has_many :rewards
  has_many :achievements, class_name: 'QuestAchievement', foreign_key: :child_id
  has_many :acquisitions, class_name: 'RewardAcquisition', foreign_key: :child_id
  has_many :grants, class_name: 'PointGrant', foreign_key: :child_id

  def todays_quests
    quests.includes(:day_of_weeks)
          .where(quest_type: :weekly, quest_day_of_weeks: { code: 0 })
          .or(quests.includes(:day_of_weeks).where.not(quest_type: :weekly))
  end
end
