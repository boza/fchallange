require "rubycritic/analysers/helpers/methods_counter"
require "rubycritic/analysers/helpers/modules_locator"

module Rubycritic
  module Analyser

    class Attributes
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.methods_count = MethodsCounter.new(analysed_module).count
          analysed_module.name = ModulesLocator.new(analysed_module).first_name
        end
      end
    end

  end
end
