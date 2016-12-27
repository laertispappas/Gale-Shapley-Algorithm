require 'spec_helper'

module GaleShapley
  describe DataGenerator do
    it 'should generate test data' do
      companies, profs = DataGenerator.generate(2)
      expect(companies.size).to eq 2
      expect(companies[1]).to be_a Company
      expect(companies[1].matches).to be_empty
      expect(companies[1].preferences).to_not be_empty
      expect(companies[1].id).to eq 1
      expect(companies[1].total_slots).not_to be_zero

      expect(companies[2]).to be_a Company
      expect(companies[2].matches).to be_empty
      expect(companies[2].preferences).to_not be_empty
      expect(companies[2].id).to eq 2
      expect(companies[2].total_slots).not_to be_zero

      expect(profs.size).to_not be_zero
      profs.each do |prof_id, prof_instance|
        expect(prof_instance).to be_a Professional
        expect(prof_instance.preferences).to_not be_empty
        expect(prof_instance.match).to be_nil
        expect(prof_instance.id).to eq prof_id
      end
    end
  end
end
