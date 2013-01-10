module Knipper
  class Device
    @device = nil
    @@lib = nil
    
    def self.devices
      @@lib ||= Blink1Lib.new
      
      num_devices = @@lib.blink1_enumerate
      devices = []
      num_devices.times do |i|
        devices << @@lib.blink1_getCachedPath(i)
      end unless num_devices < 1
      
      devices
    end
    
    def self.device_present?
      devices.length > 0
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
    end
    
    def close
      @@lib.blink1_close @device
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
    
    def read_pattern_line(pos)
      millis = FFI::MemoryPointer.new(:ushort)
      r = FFI::MemoryPointer.new(:uchar)
      g = FFI::MemoryPointer.new(:uchar)
      b = FFI::MemoryPointer.new(:uchar)
      @@lib.blink1_readPatternLine(@device, millis, r, g, b, pos)
      
      Knipper::Pattern::PatternLine.new({
        millis: millis.read_uint16, 
        red: r.read_uint8,
        green: g.read_uint8,
        blue: b.read_uint8
      })
    end
    
    def clear_pattern
      12.times do |i|
        write_pattern_line 0, 0, 0, 0, i
      end
    end
    
    def write_pattern(pattern, clear=true)
      if pattern.is_a? String
        pattern = Knipper::Pattern::Pattern.parse(pattern)
      end
      
      if pattern.is_a? Knipper::Pattern::Pattern
        clear_pattern if clear
        
        pattern.lines.each do |pattern_line|
          write_pattern_line pattern_line.millis, pattern_line.red, pattern_line.green, pattern_line.blue, pattern.lines.index(pattern_line)
        end
      end
    end
    
    def start_pattern(pos)
      @@lib.blink1_play(@device, 1, pos)
    end
    
    def stop_pattern
      @@lib.blink1_play(@device, 0, 0)
    end
  end
end
