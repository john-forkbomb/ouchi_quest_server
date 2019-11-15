# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


unless Parent.exists? && Child.exists?
  @parent = Parent.create!(name: 'お母さん',
                          email: 'mother@example.com',
                          password: 'password',
                          password_confirmation: 'password')

  @child = Child.create!(parent: @parent, name: 'たかし', sex: :male)
end

unless Quest.exists?
  @quest1 = Quest.create!(
    parent: @parent,
    child: @child,
    title: '宿題をしよう!',
    description: '毎日しっかり頑張ろう!',
    image: Rails.application.credentials.dig(:image, :study),
    point: 50
  )

  @quest2 = Quest.create!(
    parent: @parent,
    child: @child,
    title: '部屋の掃除をしよう!',
    description: '自分のお部屋はいつもきれいにしようね!',
    quest_type: :daily,
    image: Rails.application.credentials.dig(:image, :clean),
    point: 100
  )

  @quest3 = Quest.create!(
    parent: @parent,
    child: @child,
    title: '塾に行こう！',
    description: '毎日頑張ってお勉強しよう!',
    image: Rails.application.credentials.dig(:image, :study),
    quest_type: :weekly,
    point: 100
  )

  @quest3.day_of_weeks.create!(
    [
      { code: 0 },
      { code: 2 },
      { code: 4 }
    ]
  )
end

unless QuestAchievement.exists?
  QuestAchievement.create!(
    parent: @parent,
    child: @child,
    title: @quest1.title,
    point: @quest1.point,
    quest_id: @quest1.id
  )

  QuestAchievement.create!(
    parent: @parent,
    child: @child,
    title: @quest2.title,
    point: @quest2.point,
    quest_id: @quest2.id
  )
end

unless Reward.exists?
  @reward1 = Reward.create!(
    parent: @parent,
    child: @child,
    name: 'キャンディー',
    description: 'おいしい〜〜',
    image: Rails.application.credentials.dig(:image, :candy),
    point: 50
  )
  @reward2 = Reward.create!(
    parent: @parent,
    child: @child,
    name: 'ゲーム機',
    description: 'いつも欲しいって言ってたよね? 毎日クエスト頑張ろう!',
    image: Rails.application.credentials.dig(:image, :game),
    point: 10_000
  )
end

unless RewardAcquisition.exists?
  RewardAcquisition.create!(
    parent: @parent,
    child: @child,
    name: @reward1.name,
    point: @reward1.point,
    reward_id: @reward1.id
  )

  RewardAcquisition.create!(
    parent: @parent,
    child: @child,
    name: @reward2.name,
    point: @reward2.point,
    reward_id: @reward2.id
  )
end
