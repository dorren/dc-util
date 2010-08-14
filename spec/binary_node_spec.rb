require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include DcUtil

describe DcUtil::BinaryNode do 
  it "should initialize" do
    node = BinaryNode.new
    node.left.should be_nil
  end
  
  it "should add" do
    node = BinaryNode.new
    child = BinaryNode.new
    
    node.left = child
    node.left.should == child
    
    lambda {node.left = "hello"}.should raise_error
  end
  
  def to_tree(node)
    node.dfs{|x| 
      indent = "  " * x.parents.size
      puts "#{indent}#{x.object_id}"
    }
  end
  
  it "should do root leaves" do
    root = BinaryNode.new
    root.left = node1 = BinaryNode.new
    root.right = node2 = BinaryNode.new
    root.leaves.should == [node1, node2]
  end
end