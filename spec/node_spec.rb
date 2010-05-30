require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include DcUtil

describe DcUtil::Node do 
  describe "#new" do
    it "should initialize" do
      node = Node.new(1)
      node.data.should == 1
    end
  end

  describe "#add" do
    it "should only add node class object as children" do
      node = Node.new(1)
      lambda{
        node.add("something")
      }.should raise_error(ArgumentError)
    end
  
    it "should work with subclass node as well" do
      class CoolNode < DcUtil::Node; end
      class SuperCoolNode < CoolNode; end

      lambda{ # only same or subclass nodes are allowed
        CoolNode.new(1).add(Node.new(2))
      }.should raise_error(ArgumentError)
    
      lambda{
        CoolNode.new(1).add(CoolNode.new(2))
      }.should_not raise_error
  
      lambda{
        CoolNode.new(1).add(SuperCoolNode.new(2))
      }.should_not raise_error
    end
  
    
    it "should add children" do
      node = Node.new(1)
      n2 = Node.new(2)
      node.add(n2)
      node.children == [n2]
      n2.parent.should == node
    end
  end
  
  describe "#parent" do
    it "should have parent" do
      node = Node.new(1)
      n2 = Node.new(2)
      node.add(n2)
      n2.parent.should == node
    end
    
    it "should have parents" do
      node = Node.new(1)
      n2 = Node.new(2)
      n3 = Node.new(3)
      node.add(n2)
      n2.add(n3)
      node.parents.should == []
      n2.parents.should == [node]
      n3.parents.should == [n2, node]
    end
  end

  describe "traversal" do
    before(:each) do
      init_tree
    end
  
    def init_tree
      #             1
      #         /      \
      #      2           3
      #    /   \       /   \
      #   4     5     6     7
      #  /\    /
      # 8  9  10
      @tree = Node.new(1, 
               [Node.new(2,
                  [Node.new(4,
                     [Node.new(8),
                      Node.new(9)
                     ]),
                   Node.new(5, 
                     [Node.new(10)])]),
                Node.new(3,
                  [Node.new(6),
                   Node.new(7)])
               ]
             )
    end

    it "should do bfs" do
      arr = []
      @tree.bfs{|data| arr << data}
      arr.should == [1,2,3,4,5,6,7,8,9,10]
    end
    
    it "should do dfs" do
      arr = []
      @tree.dfs{|data| arr << data}
      arr.should == [1,2,4,8,9,5,10,3,6,7]
    end
  end
end