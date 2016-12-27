module GaleShapley
  module DataGenerator
    module_function

    def generate(total_companies)
      companies, professionals = {}, {}
      total_professionals = 0

      company_ids = (1..total_companies).to_a
      1.upto(company_ids.size) do |i|
        c = Company.new(rand(3) + 1, id: i, preferences: [])
        companies[i] = c
        total_professionals += c.total_slots
      end

      padding = 100
      1.upto(total_professionals) do |i|
        ids = company_ids.dup
        ids.shuffle!
        id = i + padding + total_companies
        p = Professional.new(id: id, preferences: ids)
        professionals[id] = p
      end

      prof_ids = professionals.keys
      #prof_ids = ((total_companies + padding)..(total_companies + padding + total_professionals)).to_a
      1.upto(total_companies) do |i|
        ids = prof_ids.dup
        ids.shuffle!
        companies[i].preferences = ids
      end

      return companies, professionals
    end
  end
end
