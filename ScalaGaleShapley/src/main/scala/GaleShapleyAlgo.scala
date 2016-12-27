package ScalaGaleShapley

import scala.collection.mutable

class Pool(companies: mutable.HashMap[String, Company]) {

  def isEmpty: Boolean = {
    this.companies.isEmpty
  }

  def nonEmpty: Boolean = {
    !isEmpty
  }

  def getNext: Company = {
    this.companies.head._2
  }

  def remove(company: Company) : Unit = {
    this.companies.remove(company.id)
  }

  def insert(company: Company) : Unit = {
    this.companies(company.id) = company
  }

  def isIncluded(company: Company): Boolean = {
    this.companies isDefinedAt company.id
  }

  def notIncluded(company: Company): Boolean = {
    !isIncluded(company)
  }
}

class GaleShapley(val companies: mutable.HashMap[String, Company], val professionals: mutable.HashMap[String, Person]) {

  def run() : Unit =  {
    val freeCompanies = new mutable.HashMap[String, Company]() ++ this.companies

    while(freeCompanies.nonEmpty) {
      val company = freeCompanies.head._2
      val professional = this.professionals.get(company.preferences.head._1).get

      professional.matchID match {
        case None =>
          // Make the match and delete professional from company's preferences
          professional.matchWith(company)
          company.matchWith(professional)
          company.removePreference(professional)
        case Some(previousMatchID) =>
          // If professional has more interest on the current company
          if (professional.prefers(company)) {
            // Store the pre-existing match
            val previousProfessionalCompany = this.companies.get(previousMatchID).get
            // Match with current company
            professional.matchWith(company)
            company.matchWith(professional)
            company.removePreference(professional)

            // If the previous company is not in the pool of free companies add it
            if (! ( freeCompanies isDefinedAt previousProfessionalCompany.id)) {
              freeCompanies(previousProfessionalCompany.id) = previousProfessionalCompany
            }

            // Remove previous company from professional's preferences
            // Remove professional from previous company's matches
            professional.removePreference(previousProfessionalCompany)
            previousProfessionalCompany.removeMatched(professional)
          } else  {
            professional.removePreference(company)
            company.removePreference(professional)
          }
      }

      if (company.isFull())
        freeCompanies remove company.id
    }

  }
}
