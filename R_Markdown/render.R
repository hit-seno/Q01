library(rmarkdown)

inputFile  <- commandArgs(trailingOnly = TRUE)[1]
outputFile <- commandArgs(trailingOnly = TRUE)[2]

render(inputFile, output_format = "html_document", output_file = outputFile)