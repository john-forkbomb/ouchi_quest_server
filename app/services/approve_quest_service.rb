# frozen_string_literal: true

class ApproveQuestService
  def execute!(quest)
    return false unless quest.status.finished?

    parent = quest.parent
    child = quest.child

    QuestAchievement.create!(
      parent: parent,
      child: child,
      quest_id: quest.id,
      title: quest.title,
      point: quest.point
    )

    quest.update!(status: :approved)
    child.update!(point: child.point + quest.point)
  end
end
