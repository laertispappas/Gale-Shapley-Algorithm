package ScalaGaleShapley

object GaleShapleyApp extends App {
  lazy val companies_file = args(0)
  lazy val professionals_file = args(1)
  lazy val out = args(2)

  val usage = """
    Usage: App companies.csv professionals.csv out.txt
  """

  if (args.length < 3) {
    println(usage)
    sys.exit(1)
  }
  val reader = new Reader(companies_file, professionals_file)

  val professionals = reader.readProfessionals()
  val companies = reader.readCompanies()

  val algo = new GaleShapley(companies, professionals)
  algo.run

  // Write to external File
  import java.io._
  val pw = new PrintWriter(new File(out))
  for((_, c) <- companies){
    val line = c.id + ": " + c.matches.keySet.mkString(",") + "\n"
    pw.write(line)
  }
  pw.close
}