module DcUtil
  class BinaryNode < Node
    # returns left child
    def left
      children[0]
    end
    
    # returns right child
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