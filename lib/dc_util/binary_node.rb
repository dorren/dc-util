module DcUtil
  class BinaryNode < Node
    def left
      children[0]
    end
    
    def right
      children[1]
    end
    
    # set left child
    def left=(node)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children[0] = node
      node.parent = self
    end
    
    # set right child
    def right=(node)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children[1] = node
      node.parent = self
    end
  end
end