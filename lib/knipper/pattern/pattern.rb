module Knipper
  module Pattern
    class Pattern
      attr_accessor :lines
    
      def self.parse(s)
        pattern = Pattern.new
        s.lines do |l|
          pattern.lines << PatternLine.parse(l.chomp)
        end
      
        pattern
      end
    
      def initialize
        @lines = []
      end
    
      def <<(pattern_line)
        if pattern_line.is_a? PatternLine
          lines << pattern_line
        elsif pattern_line.is_a? String
          lines << PatternLine.parse(pattern_line)
        end
      end
    end
  end
end
