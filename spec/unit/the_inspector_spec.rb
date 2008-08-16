require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "The Inspector" do

  describe "trace the method call" do
  
    it "returns nil if it can't find the event call"

    it "returns the event as a hash if it finds as a :call"

    it "returns the event as a hash if found as a :c-call"

  end
 
  describe "where is this defined?" do

    it "adds the 'where_is_this_defined' method to Kernel" do
      Kernel.respond_to?(:where_is_this_defined).should == true
    end

    it "aliases the 'where_is_this_defined' method as 'where_is_this_defined?'" do
      Kernel.respond_to?(:where_is_this_defined?).should == true
    end

    it "calls trace method call to do the heavy lifting" do
      Kernel.should_receive(:_trace_the_method_call).and_return(nil)

      Kernel.where_is_this_defined { "asdf".nil? }
    end
    
    it "returns <??> when it finds the call as a :call"

    it "returns <??> when it finds the call as a :c-call"

    it "returns <??> when it can't find the call"

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
