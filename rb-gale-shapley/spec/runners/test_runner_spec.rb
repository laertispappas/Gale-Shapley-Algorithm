require 'spec_helper'

module GaleShapley
  module Runners
    describe TestRunner do
      subject { TestRunner.new(2) }

      it 'should run the algo and fill all companies slots with the best candindates' do
        algo = subject.run!
        companies, professionals = algo.companies, algo.professionals

        puts
        companies.each do |_, c|
          p "Company #{c.id} matches: #{c.matches}"
        end

        puts ""
        professionals.each do |_, prof|
          p "Professional #{prof.id} match: #{prof.match}"
        end
      end
    end
  end
end
