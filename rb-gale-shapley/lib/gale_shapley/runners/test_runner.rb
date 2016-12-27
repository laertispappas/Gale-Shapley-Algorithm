module GaleShapley
  module Runners
    class TestRunner < Base
      def initialize(total_companies)
        @companies, @professionals = DataGenerator.generate(total_companies)
      end
    end
  end
end
