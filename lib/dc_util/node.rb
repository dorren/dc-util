module DcUtil
  # a data structure used in tree-like operations.
  class Node
    attr_accessor :children, :data, :parent
  
    def initialize(options={})
      self.data = options[:data]
      self.children = []
    end

    class << self
      # breath first search
      def bfs(node, queue, exclude_root, &block)
        return if node.nil?
        block.call(node) unless exclude_root

        node.children.each{|x| queue.push(x)}
        bfs(queue.shift, queue, false, &block)
      end

      # depth first search
      def dfs(node, exclude_root, &block)
        block.call(node) unless exclude_root
        node.children.each{|x| dfs(x, false, &block)}
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
    
    def bfs(exclude_root=false, &block)
      self.class.bfs(self, [], exclude_root, &block)
    end
    
    def dfs(exclude_root=false, &block)
      self.class.dfs(self, exclude_root, &block)
    end
  end
end

