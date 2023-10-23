# set working directory
setwd("/Users/charlescostanzo/College/Au 2023/Politsc 4998/Data/graphml_zscore_self_1_1_5_85_164/")

# load libraries
library(igraph) # for graphing
library(dplyr) # for %>% operator and mutate(), case_when() function
library(stringr) # for str_to_title() function

# read in graphml network file
g <- read_graph("114.graphml", format = "graphml")

# check vertex attribute names
vertex_attr_names(g)
# see https://voteview.com/articles/data_help_members for more info

# create a data frame "vertex_labels" containing bioname, state_abbrev, and district_code
vertex_labels <- data.frame(vertex_attr(g)$bioname, vertex_attr(g)$state_abbrev, vertex_attr(g)$district_code)

# rename "vertex_labels" columns to be more clear
names(vertex_labels) <- c("Name", "District_State", "District_Number")

# create a data frame "last_first" with two columns for last and first names
last_first <- do.call("rbind", 
        regmatches(vertex_labels$Name, regexpr(", ", vertex_labels$Name), invert = TRUE) )
last_first <- data.frame(last_first)

# rename "last_first" columns to be more appropriate
names(last_first) <- c("Last_Name", "First_Name")

# add the "last_first" columns to "vertex_labels"
vertex_labels <- cbind(vertex_labels, last_first)

# capitalize last names
vertex_labels$Last_Name <- str_to_title(vertex_labels$Last_Name)

# capitalize third character in "Mc" last names, e.g. Mccarthy --> McCarthy
# capitalize other names on a case-by-case basis

vertex_labels <- vertex_labels %>%
  mutate(Last_Name = case_when(
    grepl("Mc", vertex_labels$Last_Name) == TRUE ~ paste0(substr(vertex_labels$Last_Name,1, 2), 
                                                          toupper(substr(vertex_labels$Last_Name, 3, 3)), 
                                                          substr(vertex_labels$Last_Name, 4, nchar(vertex_labels$Last_Name))),
    Last_Name == "Desjarlais" ~ "DesJarlais",
    Last_Name == "Delbene" ~ "DelBene",
    Last_Name == "Delauro" ~ "DeLauro",
    Last_Name == "Desantis" ~ "DeSantis",
    Last_Name == "Degette" ~ "DeGette",
    Last_Name == "Defazio" ~ "DeFazio",
    Last_Name == "Lamalfa" ~ "LaMalfa",
    TRUE ~ Last_Name
  ))

# create a column 'vertex_label' that contains properly formatted vertex labels
# for each member of Congress node
vertex_labels$vertex_label <- paste0(vertex_labels$District_State, "-", round(as.numeric(vertex_labels$District_Number),0))





# create a jpeg file for figure 1
jpeg("/Users/charlescostanzo/College/Au 2023/Politsc 4998/URS Application/figure1.jpeg", 
     width = 25, height = 15, units = 'in', res = 600)

# use a multidimensional scaling layout, which is good for large, dense networks
l <- layout_with_mds(g)

# rescale coordinates to be within given bounds
l <- norm_coords(l, ymin=-1, ymax=1, xmin=-1, xmax=1)

# create graph
plot(x = g, # graph to plot
     vertex.label = vertex_labels$vertex_label,
    # vertex.label = "", # remove vertex labels
     vertex.label.cex = page_rank(g)$vector*100, #previous adjustment of vertex label size
     vertex.size = page_rank(g)$vector*500, # set the size of vertex proportional to PageRank
     vertex.color = ifelse(vertex_attr(g)$party_code == 100, "#0AC6FF", "#F21B3F"), # set vertex colors for Republicans (party_code = 200) and Democrats (party_code = 100)
    # vertex.label.font = 2, # bold vertex labels 
     vertex.frame.width = 4, # made the black frame around vertexes thicker
     edge.arrow.size = .5, # adjust edge arrow size
     edge.width = .6, # adjust edge with
     edge.arrow.width = 0.5, # adjust edge arrow width
     layout = l, # set layout to layout created above
     asp = 0, # set aspect ratio to 0
     rescale = FALSE) # do not rescale

# stop editing and output finished jpeg
dev.off() 

library(statnet)

ergm(Hookups ~ edges)
