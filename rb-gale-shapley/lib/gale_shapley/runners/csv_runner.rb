require 'csv'
module GaleShapley
  module Runners
    class CSVRunner < Base

      def initialize(companies_file, professionals_file)
        @companies = {}
        @professionals = {}

        parse_companies(companies_file)
        parse_professionals(professionals_file)
      end

      private

      def parse_companies(file)
        for_company_data_in_file(file) do |id, slots, prefs|
          @companies[id] = Company.new(slots, id: id, preferences: prefs)
        end
      end

      def parse_professionals(file)
        for_professional_data_in_file(file) do |id, prefs|
          @professionals[id] = Professional.new(id: id, preferences: prefs)
        end
      end

      def for_company_data_in_file(file)
        for_each_line_in(file) do |words_arr|
          slots = words_arr[0]
          id = words_arr[1]
          prefs = words_arr[2..-1]

          yield(id, slots, prefs)
        end
      end


      def for_professional_data_in_file(file)
        for_each_line_in(file) do |words_arr|
          id = words_arr[0]
          prefs = words_arr[1..-1]
          yield(id, prefs)
        end
      end

      def for_each_line_in(file)
        contents = File.read(file)
        contents.each_line do |line|
          words_arr = line.scan(/\w+/)
          yield(words_arr)
        end
      end

    end
  end
end
