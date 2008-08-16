require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe TheInspector do
  
 describe "where is this defined?" do

  it "adds the 'where_is_this_defined' method to Kernel" do
    Kernel.respond_to?(:where_is_this_defined).should == true
  end

  it "aliases the 'where_is_this_defined' method as 'where_is_this_defined?'" do
    Kernel.respond_to?(:where_is_this_defined?).should == true
  end

  it "uses a set trance function to trap the call given to the block"

 end

 describe "why was this defined?" do
  
  it "returns the commit message where the method first appears if the code is in a git repository"

 end

 describe "how is this defined?" do
  
  it "adds the 'how_is_this_defined' method to Kernel" do
    Kernel.respond_to?(:how_is_this_defined).should == true
  end

  it "aliases the 'how_is_this_defined' method as 'how_is_this_defined?'" do
    Kernel.respond_to?(:how_is_this_defined?).should == true
  end

  it "returns the source code by using Ruby2Ruby to generate it"

 end

 describe "when was this defined?" do
  
  it "returns a Time object if the code is in a git repository"

 end

end
