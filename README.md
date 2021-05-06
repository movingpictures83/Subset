# Subset
# Language: R
# Input: TXT (keyword-value pairs)
# Output: PREFIX 
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: phyloseq_1.34.0, microbiome_1.12.0

PluMA plugin that takes PhyloSeq-compatible input files and produces
PhyloSeq-compatible output files that contain a subset of those input files,
with user-specified properties.

The plugin accepts as input a tab-delimited parameter file of keyword value pairs:
otu: OTU table (input)
tax: TAX table (input)
meta: Metadata (input)
Description: Target value

At the moment the output file will consist of all data corresponding to samples
with metadata value "Description" equal to the target.
Future plans include extending the plugin to accomodate arbitrary metadata variables
as well as values.

Output files will be named "otu_table.csv" and "tax_table.csv", prefixed by the user-specified
output PREFIX.
