# frozen_string_literal: true

class TreeLeaf < INode
  def leaf?
    true
  end

  def composite?
    false
  end
end
