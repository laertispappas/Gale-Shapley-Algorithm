module GaleShapley
  module Runners
    class Base
      attr_reader :professionals, :companies

      def run!
        algo = Algo.new(companies, professionals)
        algo.solve!
        algo
      end
    end
  end
end
