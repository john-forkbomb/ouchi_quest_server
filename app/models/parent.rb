# frozen_string_literal: true

class Parent < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :child, dependent: :destroy

  has_many :quests
  has_many :rewards
  has_many :achievements, class_name: 'QuestAchievement', foreign_key: :parent_id
  has_many :acquisitions, class_name: 'RewardAcquisition', foreign_key: :parent_id
  has_many :grants, class_name: 'PointGrant', foreign_key: :parent_id

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
end
