require "spec_helper"

describe Knipper::Device do
  it "opens a device" do
    d = Knipper::Device.new
    d.should_not be_nil
    d.close
    d = nil
  end
  
  it "sets a color" do
    device = Knipper::Device.new
    result = device.set_rgb(255, 0, 0)
    result.should be >= 0
    device.close
  end
  
  it "fades to a color" do
    device = Knipper::Device.new
    result = device.fade_to_rgb(100, 0, 255, 0)
    result.should be >= 0
    device.close
  end
  
  it "writes a pattern" do
    device = Knipper::Device.new
    lib = Knipper::Blink1Lib.new
    device.clear_pattern
    result = device.write_pattern_line 500, 100, 150, 200, 0
    result.should be >= 0
    pattern = device.read_pattern_line 0
    pattern.millis.should eq 500
    pattern.red.should eq lib.blink1_degamma(100)
    pattern.green.should eq lib.blink1_degamma(150)
    pattern.blue.should eq lib.blink1_degamma(200)
    device.close
  end
end