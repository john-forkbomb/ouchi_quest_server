# frozen_string_literal: true

class GrantPointService
  attr_accessor :child

  def initialize(child)
    @child = child
  end

  def execute!(params)
    child.update!(point: child.point + params[:point].to_i)
    PointGrant.create!(params.merge(child: child, parent: child.parent))
  end
end
