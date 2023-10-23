# install.packages("intergraph")
library(intergraph)
library(igraph)
library(statnet)

# convert igraph object "g" to network named "net"
net <- asNetwork(g)

# extract edgelist from "g"
el.g <- get.edgelist(g)

# extract edgelist from "net"
el.net <- as.matrix(net, "edgelist")

# check if edge lists are identical
identical( as.numeric(el.g), as.numeric(el.net))

# set random seed for reproducibility
set.seed(1022)

# run very simple ergm
library(ergm)
summary(ergm(net ~ edges))


