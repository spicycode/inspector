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
    trace = _trace_the_method_call(&block)
    return "Unable to determine where the method was defined" unless trace

    if trace[:event] == 'c-call'
      "#{trace[:classname]} method :#{trace[:id]} defined in STDLIB"
    else
      "#{trace[:classname]} method :#{trace[:id]} defined in #{trace[:file]}:#{trace[:line]}"
    end
  end

end