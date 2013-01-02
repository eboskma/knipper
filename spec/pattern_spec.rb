require 'spec_helper'

describe Knipper::Pattern::Pattern do
  it "parses a series of pattern lines" do
    pattern_str = <<EOF
0,1,2,3
1,2,3,4
2,3,4,5
3,4,5,6
4,5,6,7
EOF
    pattern = Knipper::Pattern::Pattern.parse(pattern_str)
    
    pattern.lines.should_not be_nil
    pattern.lines.length.should eq 5
    pattern.lines.length.times do |i|
      pattern.lines[i].millis.should eq i
      pattern.lines[i].red.should eq i + 1
      pattern.lines[i].green.should eq i + 2
      pattern.lines[i].blue.should eq i + 3
    end
  end
end
