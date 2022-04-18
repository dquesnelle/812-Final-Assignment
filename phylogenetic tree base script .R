if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

Tree = nj(distance_metrix_name)
str(Tree)
class(Tree)

library(ggtree)
ggtree(Tree)