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
      
      # breath first search, non recursive style to prevent stack overflow
      def bfs_non_recursive(node, queue, exclude_root, &block)
        return if node.nil?
        queue.push(node)
        
        while not queue.empty?
          node = queue.shift
          block.call(node) unless exclude_root
          node.children.each{|x| queue.push(x)}
          exclude_root = false
        end
      end
      
      # depth first search
      def dfs(node, exclude_root, &block)
        block.call(node) unless exclude_root
        node.children.each{|x| dfs(x, false, &block)}
      end
    end
    
    # add a child node. 
    def add(node)
      raise ArgumentError.new("not a valid node class") unless node.kind_of? self.class
      children << node
      node.parent = self
    end
    
    def parents
      parent ? [parent] + parent.parents : []
    end
    
    # breath first search
    #   root.bfs{|node| puts node.inspect}
    #
    #   root.bfs(true){|node| puts node.inspect}  # skip first node
    def bfs(exclude_root=false, &block)
      # self.class.bfs(self, [], exclude_root, &block)
      self.class.bfs_non_recursive(self, [], exclude_root, &block)
    end
    
    # depth first search
    #   root.dfs{|node| puts node.inspect}
    #
    #   root.dfs(true){|node| puts node.inspect}  # skip first node
    def dfs(exclude_root=false, &block)
      self.class.dfs(self, exclude_root, &block)
    end
    
    # return all nodes that has no children
    def leaves
      arr = []
      self.dfs do |node|
        arr << node if node.children.empty?
      end
      arr
    end
    
    # return all nodes count
    def tree_size
      n = 0
      dfs{|x| n += 1}
      n
    end
  end
end

