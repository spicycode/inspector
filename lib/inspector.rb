require 'fileutils'
require 'rubygems'
require 'ruby2ruby'

class Inspector

  def self._collect_events_for_method_call(settings = {}, &block)
    settings[:debug] ||= false
    
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

  def self._trace_the_method_call(settings={}, &block)
    events = _collect_events_for_method_call settings, &block
    events.reject! { |event| !%w{call c-call return}.include?(event[:event]) }

    events.each do |event|

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
  def self.where_is_this_defined(settings={}, &block)
    event = _trace_the_method_call(settings, &block)

    if event
      # TODO: If the file is (irb) or event[:event] is c-call note it differently in the output
      "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{(event[:event] == 'c-call') ? 'the Ruby Standard Library' : event[:file]}"
    else
      "Unable to determine where the method was defined"
    end
  end

  def self.how_is_this_defined(settings={}, &block)
    begin
      event = _trace_the_method_call(settings, &block)

      if event
        if event[:classname].to_s == 'ActiveRecord::Base'
          "Sorry, Ruby2Ruby can't peek under the hood in ActiveRecord::Base (modules + classes == fail in ruby2ruby)"
        else
          RubyToRuby.translate(event[:classname], event[:id])
        end
      else
        "Unable to determine where the method was defined in order to get to it's source"
      end
    rescue RuntimeError => rte
      return "I have no idea.  Your codes be the fuzziest.  #{rte.inspect}"
    rescue NoMethodError => nme
      if nme.message =~ /^undefined method \`(.*)\' for nil\:NilClass/
        return "Unable to get the source for #{event[:classname]}.#{event[:id]} because it is a function defined in C"
      end 
      raise
    end
  end

end

