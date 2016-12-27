require 'spec_helper'

module GaleShapley
  module Runners
    describe CSVRunner do
      let(:companies_csv) { 
        File.join(File.dirname(__FILE__), '../../lib/samples/sample1/companies.csv')
      }
      let(:prof_csv) { 
        File.join(File.dirname(__FILE__), '../../lib/samples/sample1/professionals.csv')
      }

      subject { described_class.new(companies_csv, prof_csv) }
      it 'should read companies from external file' do
        expect(subject.companies.size).to eq 4
        expect(subject.companies.keys).to eq ['Microsoft', 'Amazon', 'Facebook', 'Oracle']
        expect(subject.companies.values.map(&:id)).to eq ['Microsoft', 'Amazon', 'Facebook', 'Oracle']
        expect(subject.companies.values.map(&:total_slots).uniq).to eq [1]
        expect(subject.companies.values.map(&:matches).flatten).to eq []

        expect(subject.companies['Microsoft'].preferences).to eq(['Bill', 'Jeff', 'Mark', 'Larry'])
        expect(subject.companies['Amazon'].preferences).to eq(['Bill', 'Jeff', 'Mark', 'Larry'])
        expect(subject.companies['Facebook'].preferences).to eq(['Mark', 'Jeff', 'Bill', 'Larry'])
        expect(subject.companies['Oracle'].preferences).to eq(['Bill', 'Mark', 'Jeff', 'Larry'])
      end

      it 'should read professionals from external file' do
        profs = subject.professionals
        expect(profs.size).to eq 4
        expect(profs.keys).to eq ['Bill', 'Jeff', 'Mark', 'Larry']
        expect(profs.values.map(&:id)).to eq ['Bill', 'Jeff', 'Mark', 'Larry']

        expect(profs['Bill'].preferences).to eq(['Microsoft', 'Facebook', 'Oracle', 'Amazon'])
        expect(profs['Jeff'].preferences).to eq(['Amazon', 'Oracle', 'Microsoft', 'Facebook'])
        expect(profs['Mark'].preferences).to eq(['Facebook', 'Oracle', 'Microsoft', 'Amazon'])
        expect(profs['Larry'].preferences).to eq(['Amazon', 'Oracle', 'Microsoft', 'Facebook'])
        expect(profs.values.map(&:match).compact).to eq []
      end

      context 'when the algorithm is run' do
        it 'matches correctly all professionals' do
          algo = subject.run!

          expect(algo.companies['Microsoft'].matches).to eq(['Bill'])
          expect(algo.companies['Amazon'].matches).to eq(['Jeff'])
          expect(algo.companies['Facebook'].matches).to eq(['Mark'])
          expect(algo.companies['Oracle'].matches).to eq(['Larry'])

          #algo.companies.each do |_, c|
          #  puts "Company #{c.id} matches: #{c.matches}"
          #end
        end
      end

      context 'sample2' do
        let(:companies_csv) { 
          File.join(File.dirname(__FILE__), '../../lib/samples/sample2/companies.csv')
        }
        let(:prof_csv) { 
          File.join(File.dirname(__FILE__), '../../lib/samples/sample2/professionals.csv')
        }

        subject { described_class.new(companies_csv, prof_csv) }

        it 'should match correctly' do
          $DEBUG = true
          algo = subject.run!

          expect(algo.companies['Microsoft'].matches).to eq(['Bill', 'Joe', 'Louis'])
          expect(algo.companies['Amazon'].matches).to eq(['Alex', 'Larry', 'Mikel', 'Tom'])
          expect(algo.companies['Facebook'].matches).to eq(['Paul'])
          expect(algo.companies['Oracle'].matches).to eq(['Bob', 'Jack', 'Jeff', 'Mark'])
        end
      end
    end
  end
end
