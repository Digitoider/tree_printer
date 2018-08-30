# frozen_string_literal: true

class INode
  attr_accessor :key, :value, :nodes

  def initialize
    @nodes = []
  end

  def leaf?
    raise NotImplementedError, 'Method `.leaf?` must be implemented.'
  end

  def composite?
    raise NotImplementedError, 'Method `.composite?` must be implemented.'
  end
end
