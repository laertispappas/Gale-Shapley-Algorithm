package ScalaGaleShapley

import scala.collection.mutable.{LinkedHashMap}

class Entity(val id: String, val preferences: LinkedHashMap[String, Int]) {
  // O(1)
  def removePreference(entity: Entity): Unit = {
    this.preferences.remove(entity.id)
  }

  override def toString = {
    this.getClass.getSimpleName + " (" + this.id + ")" + " has prefs: " + this.preferences
  }
}

class Person(id: String, preferences: LinkedHashMap[String, Int], var matchID: Option[String] = None) extends Entity(id, preferences) {
  // O(1)
  def matchWith(company: Company): Unit = {
    this.matchID = Some(company.id)
  }

  // O(1)
  def prefers(company: Company): Boolean = {
    this.preferences(company.id) < this.preferences(this.matchID.get)
  }
}

class Company(id: String, preferences: LinkedHashMap[String, Int], totalSlots: Integer = 1) extends Entity(id, preferences) {
  val matches: LinkedHashMap[String, Int] = LinkedHashMap()

  def isFull(): Boolean = {
    this.totalSlots == this.matches.size
  }

  // O(1)
  def matchWith(professional: Person): Unit = {
    this.matches(professional.id) = 1
  }

  // O(1)
  def removeMatched(professional: Person): Unit = {
    this.matches.remove(professional.id)
  }
}
