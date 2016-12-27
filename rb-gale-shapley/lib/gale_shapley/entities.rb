module GaleShapley
  class Entity
    attr_reader :id
    attr_accessor :preferences

    def initialize(preferences: , id: )
      @id = id
      @preferences = preferences
    end

    def remove_from_prefs(other)
      self.preferences.delete(other.id)
    end
  end

  class Professional < Entity
    attr_accessor :match

    def initialize(attrs)
      super(attrs)

      @match = nil
    end

    def prefers?(other)
      self.preferences.index(other.id) < self.preferences.index(self.match)
    end

    def match_with(company)
      self.match = company.id
      company.match_with(self)
    end

    def to_s
      "Profesional(#{self.id}): Prefs: " + self.preferences.to_s
    end

    def inspect
      to_s
    end
  end

  class Company < Entity
    attr_reader :total_slots, :matches

    def initialize(total_slots = 1, opts)
      super(opts)

      @total_slots = total_slots.to_i
      @matches = []
    end

    def match_with(professional)
      self.matches << professional.id
      self.preferences.delete(professional.id)
    end

    def remove_matched(professional)
      self.matches.delete(professional.id)
    end

    def full?
      self.total_slots == self.matches.size
    end

    def to_s
      "Company(#{self.id}) has: " + self.total_slots.to_s + " total slots. Prefs: " + self.preferences.to_s
    end

    def inspect
      to_s
    end
  end

end
