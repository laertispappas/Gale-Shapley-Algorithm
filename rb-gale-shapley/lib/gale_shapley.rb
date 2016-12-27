require "gale_shapley/version"
require "gale_shapley/entities"
require "gale_shapley/data_generator"
require "gale_shapley/algo"
require "gale_shapley/runners"

module GaleShapley
  class << self

    def Run(type, *args)
      case type
      when :csv
        Runners::CSVRunner.new(args[0], args[1]).run!
      end
    end

  end
end
