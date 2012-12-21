require 'knipper'

class BlinkFormatter < RSpec::Core::Formatters::BaseFormatter
  def initialize(output)
    super(output)
  end
  
  def stop
    if @failed_examples.length > 0
      Knipper::Device.new { |d| d.fade_to_rgb 500, 255, 0, 0 }
    else
      Knipper::Device.new { |d| d.fade_to_rgb 500, 0, 255, 0 }      
    end
  end
end

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  config.add_formatter BlinkFormatter
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

