require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Inspector do

  describe "trace the method call" do
  
    it "returns nil if it can't find the event call"

    it "returns the event as a hash if it finds as a :call"

    it "returns the event as a hash if found as a :c-call"

  end
 
  describe "where is this defined?" do

    it "adds the 'where_is_this_defined' method to Kernel" do
      Inspector.respond_to?(:where_is_this_defined).should == true
    end

    it "calls trace method call to do the heavy lifting" do
      Inspector.should_receive(:_trace_the_method_call).and_return(nil)

      Inspector.where_is_this_defined { "asdf".nil? }
    end
    
    it "returns <??> when it finds the call as a :call"

    it "returns <??> when it finds the call as a :c-call"

    it "returns <??> when it can't find the call"


    describe "when asking about a standard library method" do

      it "returns a friendly sorry, but we can't help you message" do
        Inspector.where_is_this_defined { 'asdf'.reverse }.should == "String received message 'reverse', Line #37 of the Ruby Standard Library"
      end

    end

  end

  describe "why was this defined?" do

    it "returns the commit message where the method first appears if the code is in a git repository"

  end

  describe "how is this defined" do

    it "adds the 'how_is_this_defined' method to Kernel" do
      Inspector.respond_to?(:how_is_this_defined).should == true
    end

    it "returns the source code by using Ruby2Ruby to generate it"

    describe "when asking about a standard library method" do

      it "returns a friendly sorry, but we can't help you message" do
        Inspector.how_is_this_defined { 'asdf'.reverse }.should == "Unable to get the source for String.reverse because it is a function defined in C"
      end

    end

    describe "when asking asking about Foo.cls_method's source" do
      class Foo
        def self.cls_method
          "asdf"
        end
      end

      it "returns the source all on one line" do
        pending("Failing because of ???") do
          Inspector.how_is_this_defined { Foo.cls_method }.should == "def self.cls_method\n\"asdf\"\nend"
        end
      end

    end

  end

  describe "when was this defined?" do

    it "returns a Time object if the code is in a git repository"

  end

end

