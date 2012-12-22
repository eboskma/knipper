require "spec_helper"

describe Knipper::Device do
  before(:each) { @device = Knipper::Device.new }
  after(:each) { @device = nil }
  
  it "opens a device" do
    d = Knipper::Device.new
    d.should_not be_nil
    d = nil
  end
  
  it "sets a color" do
    result = @device.set_rgb(255, 0, 0)
    result.should be >= 0
  end
  
  it "fades to a color" do
    result = @device.fade_to_rgb(100, 0, 255, 0)
    result.should be >= 0
  end
end