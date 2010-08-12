module DcUtil
  # a data structure used in tree-like operations.
  class Node
    attr_accessor :children, :data, :parent
  
    def initialize(data, values=[])
      self.data = data
      self.children = []
      values.each{|x| self.add(x)}
    end

    class << self
      # breath first search
      def bfs(node, queue, &block)
        return if node.nil?
        block.call(node.data)

        node.children.each{|x| queue.push(x)}
        bfs(queue.shift, queue, &block)
      end

      # depth first search
      def dfs(node, &block)
        block.call(node.data)
        node.children.each{|x| dfs(x, &block)}
      end
    end
    
    def add(node, &block)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children << node
      node.parent = self
      yield self if block_given?
    end
    
    def parents
      parent ? [parent] + parent.parents : []
    end
    
    def bfs(&block)
      self.class.bfs(self, [], &block)
    end
    
    def dfs(&block)
      self.class.dfs(self, &block)
    end
  end
end

