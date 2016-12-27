require 'spec_helper'

module GaleShapley
  describe Company do
    subject { Company.new(3, id: 1, preferences: ['john', 'doy']) }

    it { expect(subject).to be_a Entity }
    it { expect(subject.id).to eq 1 }
    it { expect(subject.preferences).to eq ['john', 'doy'] }
    it { expect(subject.total_slots).to eq 3 }
    it { expect(subject.matches).to eq [] }
  end

  describe Professional do
    subject { Professional.new(id: 1, preferences: ['pamediakopes', 'Google']) }
    it { expect(subject.id).to eq 1 }
    it { expect(subject.preferences).to eq ['pamediakopes', 'Google'] }
    it { expect(subject.match).to eq nil }
  end
end
