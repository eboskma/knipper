require 'ffi'
module Knipper
  
  class Blink1Lib
    extend FFI::Library
  
    libname = "blink1-lib"
    if FFI::Platform.mac?
      libname = "libBlink1"
    end
    
    ffi_lib [libname, "/usr/local/lib/#{libname}"]
  
    attach_function :blink1_enumerate, [], :int
    attach_function :blink1_getCachedPath, [:int], :string
  
    attach_function :blink1_open, [], :pointer
    attach_function :blink1_openByPath, [:string], :pointer
    attach_function :blink1_close, [:pointer], :void
    attach_function :blink1_play, [:pointer, :uchar, :uchar], :int
    attach_function :blink1_writePatternLine, [:pointer, :ushort, :uchar, :uchar, :uchar, :uchar], :int
    attach_function :blink1_readPatternLine, [:pointer, :pointer, :pointer, :pointer, :pointer, :uchar], :int
    attach_function :blink1_degamma, [:int], :int
    
    attach_function :blink1_setRGB, [:pointer, :uchar, :uchar, :uchar], :int
    attach_function :blink1_fadeToRGB, [:pointer, :ushort, :uchar, :uchar, :uchar], :int
    
  end
end