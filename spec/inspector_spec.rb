require 'spec_helper'
require 'crazy_example_object'

describe Inspector do

  describe "where is this defined?" do

    it "adds the 'where_is_this_defined' method to Kernel" do
      Inspector.respond_to?(:where_is_this_defined).should == true
    end

    it "calls trace method call to do the heavy lifting" do
      Inspector.should_receive(:_trace_the_method_call).and_return(nil)

      Inspector.where_is_this_defined { "asdf".nil? }
    end

    it "returns a message indicating what file received the message on what line when it finds the call as a :call" do
      Inspector.where_is_this_defined { 
        CrazyExampleObject.class_method_foo 
      }.should =~ /CrazyExampleObject method :class_method_foo defined in .*:\d+/
    end

    it "raises a no method error when it can't find the call" do
      lambda {Inspector.where_is_this_defined { "asdf".french_fry? }}.should raise_error(NoMethodError)
    end

    describe "when asking about a standard library method" do

      it "returns a friendly sorry, but we can't help you message" do
        Inspector.where_is_this_defined { 'asdf'.reverse }.should == 'String method :reverse defined in STDLIB'
      end

    end

  end

end
