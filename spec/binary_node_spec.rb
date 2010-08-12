require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include DcUtil

describe DcUtil::BinaryNode do 
  it "should initialize" do
    node = BinaryNode.new(1)
    node.left.should be_nil
  end
  
  it "should add" do
    node = BinaryNode.new(1)
    child = BinaryNode.new(2)
    
    node.left = child
    node.left.should == child
    
    lambda {node.left = "hello"}.should raise_error
  end
  
end