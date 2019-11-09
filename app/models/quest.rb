# frozen_string_literal: true

class Quest < ApplicationRecord
  extend Enumerize

  belongs_to :parent
  belongs_to :child

  has_many :day_of_weeks, class_name: 'QuestDayOfWeek', foreign_key: :quest_id

  validate :check_point

  enumerize :quest_type, in: %i[daily weekly emergency], default: :daily
  enumerize :status, in: %i[none finished approved], default: :none

  def self.todays
    code = 0
    Quest.includes(:day_of_weeks).where(day_of_weeks: { code: code })
  end

  def check_point
    return if (point % 50).zero? && point <= 1000

    errors.add(:point, 'ポイントは50の倍数で, 1000ポイント以下設定する必要があります')
  end
end
