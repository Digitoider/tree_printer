# frozen_string_literal: true

class Treeorizer
  def self.process(hash)
    process_recursive('root', hash)
  end

%{

h = { a: 1, b: 2, 'c' => 3}
TreePrinter.new.print(h)

h = {
  a: 1,
  b: {
    b1: 'less smell',
    b2: 4,
    b3: {
      sdf: 'dsf'
    },
    coords: {
      'lat' => 45.84564,
      'lng' => 64.33234
    }
  }
}
TreePrinter.new.print(h)

}

  protected

  def self.process_recursive(key, hash)
    node = Tree.new
    node.key = key
    hash.each do |key, value|
      if value.is_a?(Hash)
        node.nodes << process_recursive(key, value)
      else
        leaf = TreeLeaf.new
        leaf.key = key
        leaf.value = value
        node.nodes << leaf
      end
    end
    node
  end
end
