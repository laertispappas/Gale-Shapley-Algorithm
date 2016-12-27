package ScalaGaleShapley

import scala.collection.mutable
import scala.io.Source
import scala.collection.mutable.{HashMap}

class Reader(val companiesFilename: String, val professionalsFilename: String) {
  val numPattern = "\\w+".r

  def readCompanies(): HashMap[String, Company] = {
    val companies = new HashMap[String, Company]

    val bufferedSource = Source.fromFile(companiesFilename)
    for (line <- bufferedSource.getLines) {
      val words = numPattern.findAllIn(line).toList

      val slots = words(0)
      val companyName = words(1)
      val companyPreferencesList = words.slice(2, words.length)

      var rank = 1
      val preferencesMap = mutable.LinkedHashMap[String, Int]()
      for(preference <- companyPreferencesList) {
        preferencesMap(preference) = rank
        rank += 1
      }
      companies(companyName) = new Company(id = companyName, preferences = preferencesMap, totalSlots = slots.toInt)
    }
    bufferedSource.close
    companies
  }

  def readProfessionals(): HashMap[String, Person] = {
    val professionals = new HashMap[String, Person]

    val source = Source.fromFile(professionalsFilename)
    for(line <- source.getLines) {
      val words = numPattern.findAllIn(line).toList

      val personName = words(0)
      val personPreferencesList = words.slice(1, words.length)

      var rank = 1
      val preferencesMap = mutable.LinkedHashMap[String, Int]()

      for (preference <- personPreferencesList) {
        preferencesMap(preference) = rank
        rank += 1
      }
      professionals(personName) = new Person(personName, preferencesMap)
    }

    professionals
  }
}
