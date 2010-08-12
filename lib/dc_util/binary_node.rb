module DcUtil
  class BinaryNode < Node
    def left
      children[0]
    end
    
    def right
      children[1]
    end
    
    def left=(node)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children[0] = node
      node.parent = self
    end
    
    def right=(node)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children[1] = node
      node.parent = self
    end
  end
end