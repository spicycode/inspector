require 'fileutils'
require 'rubygems'
require 'ruby2ruby'

class Inspector

  def self._collect_events_for_method_call(&block)
  
    events = []
    
    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }
    }
    
    begin
      yield
    ensure
      set_trace_func(nil)
    end

    events
  end

  def self._trace_the_method_call(&block)
    events = _collect_events_for_method_call &block
    
    # events.reject! { |event| !%w{call c-call return}.include?(event[:event]) }
    valid_event_types = ['call', 'c-call', 'return']
    
    events.each do |event|
      next unless valid_event_types.include?(event[:event])
      
      case event[:classname].to_s
        when 'ActiveRecord::Base'
          return events[-3]
        else
          return event if event[:event].include?('call')
      end
    end

  end

# Original version from http://holgerkohnen.blogspot.com/
# which { some_object.some_method() } => <file>:<line>:
  def self.where_is_this_defined(&block)
    event = _trace_the_method_call(&block)

    if event
      # TODO: If the file is (irb) or event[:event] is c-call note it differently in the output
      "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{(event[:event] == 'c-call') ? 'the Ruby Standard Library' : event[:file]}"
    else
      "Unable to determine where the method was defined"
    end
  end

  def self.how_is_this_defined(&block)
    begin
      event = _trace_the_method_call(&block)

      if event
        ::RubyToRuby.translate(event[:classname], event[:id])
      else
        "Unable to determine where the method was defined in order to get to it's source"
      end
    rescue RuntimeError => rte
      # Assuming class level method
      return ::RubyToRuby.translate(event[:classname], "self.#{event[:id]}")
    rescue NoMethodError => nme
      if nme.message =~ /^undefined method \`(.*)\' for nil\:NilClass/
        return "Unable to get the source for #{event[:classname]}.#{event[:id]} because it is a function defined in C"
      end 
      raise
    rescue Exception => ex
      if event[:classname].to_s == 'ActiveRecord::Base'
        return "Sorry, Ruby2Ruby can't peek under the hood in ActiveRecord::Base (modules + classes == fail in ruby2ruby)"
      end
      raise
    end
  end
  
  def self.who_defined_it(&block)
    event = _trace_the_method_call(&block)
  
    
    # git log -S'def self.where_is_this_defined' --pretty=format:%an
  end
  
  def self.detector(&block)
    where = where_is_this_defined(&block)
    how = how_is_this_defined(&block)
    
    "Sir, here are the details of your inquiry:\n\nThe method in question was found to be defined in:\n#{where}\n\nAlso, it was found to look like the following on the inside:\n#{how}\n\n"
  end

end

