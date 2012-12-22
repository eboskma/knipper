module Knipper
  class Device
    @device = nil
    @@lib = nil
    
    def self.devices
      @@lib ||= Blink1Lib.new
      
      num_devices = @@lib.blink1_enumerate
      devices = []
      puts "#{num_devices} blink(1) devices found"
      num_devices.times do |i|
        devices << @@lib.blink1_getCachedPath(i)
      end unless num_devices < 1
      
      devices
    end
    
    def self.finalize
      proc { @@lib.blink1_close @device }
    end
    
    def initialize(path = nil, &block)
      @@lib ||= Blink1Lib.new
      if path
        @device = @@lib.blink1_openByPath path
      else
        @device = @@lib.blink1_open
      end
      if block_given?
        yield self
        @@lib.blink1_close @device
        return
      end
      
      ObjectSpace.define_finalizer(self, self.class.finalize())
    end
    
    def fade_to_rgb(millis, red, green, blue)
      @@lib.blink1_fadeToRGB(@device, millis, red, green, blue)
    end
    
    def set_rgb(red, green, blue)
      @@lib.blink1_setRGB(@device, red, green, blue)
    end
    
    def write_pattern_line(millis, red, green, blue, pos)
      @@lib.blink1_writePatternLine(@device, millis, red, green, blue, pos)
    end
    
    def start_pattern(pos)
      @@lib.blink1_play(@device, 1, pos)
    end
    
    def stop_pattern
      @@lib.blink1_play(@device, 0, 0)
    end
  end
end