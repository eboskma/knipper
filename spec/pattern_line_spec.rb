require "spec_helper"

describe Knipper::Pattern::PatternLine do
  it "parses a valid string" do
    pattern_str = "500,128,65,233"
    pattern = Knipper::Pattern::PatternLine.parse(pattern_str)
    
    pattern.should_not be_nil
    pattern.millis.should eq 500
    pattern.red.should eq 128
    pattern.green.should eq 65
    pattern.blue.should eq 233
  end
  
  it "raises an error when parsing an invalid string" do
    pattern_str = "asdf"
    expect { Knipper::Pattern::PatternLine.parse(pattern_str) }.to raise_error("Unrecognized pattern -- #{pattern_str}")
  end
end