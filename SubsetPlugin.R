dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

library(phyloseq)
library(microbiome)

input <- function(inputfile) {
  #print("HI")
  pfix = prefix()
  if (length(pfix) != 0) {
     pfix <- paste(pfix, "/", sep="")
  }
  #print(pfix)
  parameters <- read.table(inputfile, as.is=T);
  rownames(parameters) <- parameters[,1]
  #print(parameters)
  
  otufile <<- paste(pfix, toString(parameters["otu",2]), sep="")
  taxfile <<- paste(pfix, toString(parameters["tax",2]), sep="")
  metafile <<- paste(pfix, toString(parameters["meta",2]), sep="")
  description <<- toString(parameters["Description",2])

  x <<- read_csv2phyloseq(
  otu.file = otufile,
  taxonomy.file = taxfile,
  metadata.file = metafile,
  sep = ","
  )

  print(sample_data(x)$Description)

}

run <- function() {
   y <<- subset_samples(x, sample_data(x)$Description==description)
   y <<- prune_taxa(taxa_sums(y) > 0, y)
   print(sample_data(y))
}

output <- function(outputfile) {
   OTU1 = as(otu_table(y), "matrix")
   #if(taxa_are_rows(ps)){OTU1 <- t(OTU1)}
   # Coerce to data.frame
   OTUdf = as.data.frame(OTU1)
   write.csv(OTUdf, file=paste(outputfile, "otu_table.csv", sep="/") )

   TAX1 = as(tax_table(y), "matrix")
   TAXdf = as.data.frame(TAX1)
   write.csv(TAXdf, file=paste(outputfile, "tax_table.csv", sep="/") )
}
