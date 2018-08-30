# frozen_string_literal: true

require "tree_printer/version"

class TreePrinter
  VERSION = '0.1.0'

  attr_reader :result

  def initialize
    @result = []
  end

  def print(tree)
    reset_result!
    build_result(tree)
    result.each { |str| puts str }
  end

  def build_result(tree)
    @result << tree.key
    build_result_recursive!(tree)
    @result
  end

  def reset_result!
    @result = []
  end

  protected

  def build_result_recursive!(current_node, base_output = '')
    nodes_amount = current_node.nodes.count
    current_node.nodes.each_with_index do |node, index|
      next @result << get_leaf(base_output, node.key, node.value, nodes_amount, index) if node.leaf?
      @result << get_composite(base_output, node.key, nodes_amount, index) if node.composite?
      build_result_recursive!(node, format_base_output(base_output, nodes_amount, index))
    end
  end

  def format_base_output(base_output, nodes_amount, current_node_index)
    return "#{base_output}   " if nodes_amount == 1 || current_node_index == nodes_amount - 1
    return "#{base_output}#{pattern_branch_empty_last}" if current_node_index == nodes_amount - 1
    "#{base_output}#{pattern_branch_empty_intermediate}"
  end

  def last?(nodes_amount, current_node_index)
    current_node_index == nodes_amount - 1
  end

  def get_composite(base_output, key, nodes_amount, current_node_index)
    return "#{base_output}#{pattern_branch_ramificating_last}#{pattern_key(key)}" if last?(nodes_amount, current_node_index)
    "#{base_output}#{pattern_branch_ramificating_intermediate}#{pattern_key(key)}"
  end

  def get_leaf(base_output, key, value, nodes_amount, current_node_index)
    return "#{base_output}#{pattern_branch_ramificating_last}#{pattern_key(key)}#{pattern_value(value)}" if last?(nodes_amount, current_node_index)
    "#{base_output}#{pattern_branch_ramificating_intermediate}#{pattern_key(key)}#{pattern_value(value)}"
  end

  def pattern_key(key)
    "#{key}"
  end

  def pattern_value(value)
    ": #{value}"
  end

  def print_s(base_output = '')
    puts "#{base_output}|--"
  end

  def pattern_branch_empty_last
    '+--'
  end

  def pattern_branch_empty_intermediate
    '|  '
  end

  def pattern_branch_ramificating_intermediate
    '|--'
  end

  def pattern_branch_ramificating_last
    '`--'
  end
end

