module GaleShapley
  class Pool
    def initialize(entities)
    end
    # TODO API: delete / include / Add / any? / get first
  end

  class Algo
    attr_reader :companies, :professionals

    def initialize(companies, professionals)
      @companies = companies
      @professionals = professionals

      if $DEBUG
        puts "Matching #{@companies.size} companies with #{professionals.size} professionals"
        puts "Companies data:"
        @companies.each do |_, v|
          p v
        end

        puts "Professionals data:"
        @professionals.each do |_, v|
          p v
        end

      end
    end

    def solve!
      free_companies_pool = companies.dup

      while free_companies_pool.any?
        company = free_companies_pool.first[1]
        professional = professionals[company.preferences[0]]

        # When professional does not have any match yet we match him with the company
        if professional.match.nil?
          professional.match_with(company)

          # Professional is already matched with another company. We check
          # to see if the current company is better than the previous match
        else

          # current company is a better match than the previous company
          if professional.prefers?(company)
            previous_company = companies[professional.match]
            professional.match_with(company)

            unless free_companies_pool.keys.include?(previous_company.id)
              free_companies_pool[previous_company.id] = previous_company
            end

            professional.remove_from_prefs(previous_company)
            previous_company.remove_matched(professional)
          else
            professional.remove_from_prefs(company)
            company.remove_from_prefs(professional)
          end
        end
        # If company is full remove it from poll of free companies
        if company.full?
          free_companies_pool.delete(company.id)
        end

      end # End while

    end # End solve

  end
end
