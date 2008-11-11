require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'crazy_example_object')


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

    it "returns a message indicating what file received the message on what line when it finds the call as a :call" do
      Inspector.where_is_this_defined { CrazyExampleObject.class_method_foo }.should =~ /received message '.*', Line \#\d+ of .*\.rb/
    end

    it "raises a no method error when it can't find the call" do
      lambda {Inspector.where_is_this_defined { "asdf".french_fry? }}.should raise_error(NoMethodError)
    end

    describe "when asking about a standard library method" do

      it "returns a friendly sorry, but we can't help you message" do
        Inspector.where_is_this_defined { 'asdf'.reverse }.should =~ /String received message 'reverse', Line #\d+ of the Ruby Standard Library/
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

    it "returns the source code by using Ruby2Ruby to generate it" do
      pending("Ruby2Ruby fall down, go boom") do
        Inspector.how_is_this_defined { Inspector.how_is_this_defined {  } }.should =~ /def self\.how_is_this_defined/
      end
    end

    describe "when asking about a standard library method" do

      it "returns a friendly sorry, but we can't help you message" do
        pending("Ruby2Ruby fall down, go boom") do
          Inspector.how_is_this_defined { 'asdf'.reverse }.should == "Unable to get the source for String.reverse because it is a function defined in C"
        end
      end

    end

    describe "when asking asking for CrazyExampleObject.class_method_foo's source" do

      it "returns the source all on one line" do
        pending("Ruby2Ruby fall down, go boom") do
          Inspector.how_is_this_defined { CrazyExampleObject.class_method_foo }.should == "def self.class_method_foo\n  \"class_method\"\nend"
        end
      end

    end

    describe "when asking asking for CrazyExampleObject.new.instance_method_foo's source" do

      it "returns the source all on one line" do
        pending("Ruby2Ruby fall down, go boom") do
          crazy = CrazyExampleObject.new
          Inspector.how_is_this_defined { crazy.instance_method_foo }.should == "def instance_method_foo\n  \"instance_method\"\nend"
        end
      end

    end

  end

  describe "detector" do

    it "asks where is this defined" do
      Inspector.stub!(:how_is_this_defined)
      Inspector.should_receive(:where_is_this_defined)
      Inspector.detector { CrazyExampleObject.class_method_foo }
    end

    it "asks how is this defined" do
      Inspector.should_receive(:how_is_this_defined)
      Inspector.detector { CrazyExampleObject.class_method_foo }
    end

    it "uses overly colorful language to describe the result set" do
      pending("Ruby2Ruby fall down, go boom") do
        result = Inspector.detector { CrazyExampleObject.class_method_foo }
        result.should =~ /Sir, here are the details of your inquiry/
        result.should =~ /found to be defined in/
        result.should =~ /inside/
      end
    end

  end

  describe "when was this defined?" do

    it "returns a Time object if the code is in a git repository"

  end

end

