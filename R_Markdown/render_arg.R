library(rmarkdown)

inputFile  <- commandArgs(trailingOnly = TRUE)[1]
outputFile <- commandArgs(trailingOnly = TRUE)[2]
override_arg01 <- commandArgs(trailingOnly = TRUE)[3]
override_arg02 <- commandArgs(trailingOnly = TRUE)[4]
override_arg03 <- commandArgs(trailingOnly = TRUE)[5]

render(inputFile, output_format = "html_document", output_file = outputFile, 
       params = list(arg01=override_arg01,
                     arg02=override_arg02,
                     arg03=override_arg03))
