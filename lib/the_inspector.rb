require 'fileutils'
require 'rubygems'
require 'ruby2ruby'

module TheInspector

  def _trace_the_method_call(settings = {}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false
    
    events = []
    
    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }
      
      if settings[:debug]
        puts "event => #{event}"
        puts "file => #{file}"
        puts "line => #{line}"
        puts "id => #{id}"
        puts "binding => #{binding}"
        puts "classname => #{classname}"
        puts ''
      end
    }
    yield
    set_trace_func(nil)

    events.each do |event|
      # TODO: c-call, c-return are the stdlib c return/calls we should handle em'
      next unless event[:event] == 'call' || (event[:event] == 'return' && event[:classname].included_modules.include?(ActiveRecord::Associations))
      return event
    end
    
    # def self.crazy_custom_finder
    #  return find(:all......)
    # end
    # return unless event == 'call' or (event == 'return' and classname.included_modules.include?(ActiveRecord::Associations))
    # which_file = "Line \##{line} of #{file}"
    # TODO: Document, test if still needed
    return events[-3] if settings[:educated_guess] && events.size > 3
    
    nil
  end

  # Original version from http://holgerkohnen.blogspot.com/
  # which { some_object.some_method() } => <file>:<line>:
  def where_is_this_defined(settings={}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false
   
    event = _trace_the_method_call(settings, &block)

    if event
      "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}"
    else
      'Unable to determine where method was defined.'
    end
  end
  alias :where_is_this_defined? :where_is_this_defined

  def how_is_this_defined
    RubyToRuby.translate(String, :blank?)
  end
  alias :how_is_this_defined? :how_is_this_defined

end

Kernel.class_eval do
  extend TheInspector
end

