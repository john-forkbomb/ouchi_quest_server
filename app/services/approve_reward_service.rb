# frozen_string_literal: true

class ApproveRewardService
  def execute!(reward)
    parent = reward.parent
    child = reward.child

    reward.update!(status: :approved)

    RewardAcquisition.create!(
      parent: parent,
      child: child,
      reward_id: reward.id,
      name: reward.name,
      point: reward.point
    )

    child.update!(point: child.point - reward.point)
  end
end
