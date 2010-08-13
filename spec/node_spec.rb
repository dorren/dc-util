require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include DcUtil

describe DcUtil::Node do 
  describe "#new" do
    it "should initialize" do
      node = Node.new(:data => 1)
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
        CoolNode.new(:data => 1).add(Node.new(:data => 2))
      }.should raise_error(ArgumentError)
    
      lambda{
        CoolNode.new(:data => 1).add(CoolNode.new(:data => 2))
      }.should_not raise_error
  
      lambda{
        CoolNode.new(:data => 1).add(SuperCoolNode.new(:data => 2))
      }.should_not raise_error
    end
  
    
    it "should add children" do
      node = Node.new(:data => 1)
      n2 = Node.new(:data => 2)
      node.add(n2)
      node.children == [n2]
      n2.parent.should == node
    end
  end
  
  describe "#parent" do
    it "should have parent" do
      node = Node.new(:data => 1)
      n2 = Node.new(:data => 2)
      node.add(n2)
      n2.parent.should == node
    end
    
    it "should have parents" do
      node = Node.new(:data => 1)
      n2 = Node.new(:data => 2)
      n3 = Node.new(:data => 3)
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
      @tree = Node.new(:data => 1)
      n2 = Node.new(:data => 2)
      n3 = Node.new(:data => 3)
      n4 = Node.new(:data => 4)
      n5 = Node.new(:data => 5)
      n6 = Node.new(:data => 6)
      n7 = Node.new(:data => 7)
      n8 = Node.new(:data => 8)
      n9 = Node.new(:data => 9)
      n10 = Node.new(:data => 10)
      
      @tree.add n2
      @tree.add n3
      n2.add n4
      n2.add n5
      n4.add n8
      n4.add n9
      n5.add n10
      n3.add n6
      n3.add n7
    end

    it "should do bfs" do
      arr = []
      @tree.bfs{|node| arr << node.data}
      arr.should == [1,2,3,4,5,6,7,8,9,10]
    end
    
    it "should do bfs exclude root" do
      arr = []
      @tree.bfs(true){|node| arr << node.data}
      arr.should == [2,3,4,5,6,7,8,9,10]
    end
    
    it "should do dfs" do
      arr = []
      @tree.dfs{|node| arr << node.data}
      arr.should == [1,2,4,8,9,5,10,3,6,7]
    end
    
    it "should do dfs exclude root" do
      arr = []
      @tree.dfs(true){|node| arr << node.data}
      arr.should == [2,4,8,9,5,10,3,6,7]
    end
    
    it "should count tree size" do
      @tree.tree_size.should == 10
    end
  end
end