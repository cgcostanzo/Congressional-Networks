# set working directly to proper folder
setwd("/Users/charlescostanzo/College/Au 2023/Politsc 4998/URS Application/")

# load "igraph" library
library(igraph)

# create graph
g2 <- graph( edges=c("Node 1","Node 2", "Node 2","Node 1"))

# create a jpeg file for figure 2 (a node vertex plot)
jpeg("figure2.jpeg", width = 7, height = 7, units = 'in', res = 600)

# set a random seed
set.seed(1)

# create graph
plot(x = g2, # graph to plot
     vertex.color = c("#e5f5e0", "#a1d99b"), # adjust vertex colors
     vertex.size = 50, # adjust vertex size
     vertex.label.cex = 1.5, # adjust vertex label size
     vertex.label.family="Times", # adjust vertex label font (Times New Roman)
     vertex.label.font = 2, # bold vertex label font
     vertex.label.color = "black", # make vertex label color "black"
     vertex.frame.width = 2, # make vertex frame thicker
     edge.color = "black", # make edges "black"
     edge.label = "Edge", # label edge "Edge"
     edge.label.cex = 1.5, # adjust edge label size
     edge.label.x = -0.2, # adjust edge label x position
     edge.label.y = .2, # adjust edge label y position
     edge.label.color = "black", # make edge labels "black"
     edge.label.font = 2) # bold edge labels

# stop editing and output finished jpeg to working directory
dev.off()

# create a jpeg file for figure 3 (a tree network created using preferential attachment algorithm)
jpeg("figure3.jpeg", width = 7, height = 7, units = 'in', res = 600)

# set a random seed
set.seed(2)

# generate tree network using preferential attachment algorithm
n <- 100 # set number of nodes
net.bg <- sample_pa(n) 

# set color palette
colors100 <- sample(c("#FFD5AD","#FFA552","#F57600","#77B6EA", "#2183D4", "#16588D"), size = n, replace = TRUE)

# randomly create vector containing sizes for each node
cex100 <- sample(2:9, size = n, replace = TRUE)

# set vertex frame color to "black"
V(net.bg)$frame.color <- "black"

# set node colors to color palette "colors100"
V(net.bg)$color <- colors100

# remove node labels
V(net.bg)$label <- ""

# set node sizes to size vector "cex100"
V(net.bg)$size <- cex100

# do not show arrows
E(net.bg)$arrow.mode <- 0

# plot network
plot(net.bg)

# stop editing and output finished jpeg to working directory
dev.off()
