# frozen_string_literal: true

class Tree < INode
  def leaf?
    false
  end

  def composite?
    true
  end
end
