module Knipper
  module Pattern
    class PatternLine
      attr_accessor :millis, :red, :green, :blue
      
      PATTERN = /\A(\d+),(\d+),(\d+),(\d+)\z/
      
      def self.parse(s)
        parts = PATTERN.match(s)
        raise "Unrecognized pattern -- #{s}" unless parts

        pattern_line = PatternLine.new
        pattern_line.millis = parts[1].to_i
        pattern_line.red = parts[2].to_i
        pattern_line.green = parts[3].to_i
        pattern_line.blue = parts[4].to_i
        
        pattern_line
      end
      
      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
  
    end
  end
end