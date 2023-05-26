Feature: Extract Text from PDF using PDFBox

Background:
  #* configure karate.classpath('path/to/your/pdfbox.jar')
 # Only needed if we haven't downloaded the dependency.
Scenario: Extract text from a PDF
  Given def PDFTextExtractor = Java.type('com.example.PDFTextExtractor')
  And def pdfPath = 'src/test/java/ReqResApp/testData/testFile.pdf'
  When def extractedText = PDFTextExtractor.extractText(pdfPath)
  Then print extractedText