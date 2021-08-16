#######################
# R ggplot and ggsave #
#######################

#---------------------------------------------------#
# ggplot with Base R                                # 
# plot an x axis (no y axis)                        #
# an x axis with a bar plot sums the y axis         #
# the y axis                                        #
# must use the word 'data' - can't use own variable #
#---------------------------------------------------#

require(data.table)
require(ggplot2)
require(dplyr)

simpsons <- fread('/home/alice/R/Simpsons_Missing_Values_Dups.csv', fill = TRUE, na.strings = "")
simpsons
# simpsons[is.na(Gender), Gender := 'no tag']
head(simpsons)

# get rid of missing data across data table with complete.cases function

simpsons_complete <- simpsons[complete.cases(simpsons), ]

ggplot(data = simpsons_complete) + geom_bar(mapping = aes(x = Gender, color = Gender))
ggsave('Simpsons1.png')

ggplot(data = simpsons_complete) + geom_bar(mapping = aes(x = Gender, fill = Gender))
ggsave('Simpsons2.png')

################################################################
# ggplot dplyr for x and y axis charts / plots - easier syntax #
################################################################

simpsons_complete %>%
  ggplot(aes(Name,Gender, fill = Address)) +
 geom_point(alpha=0.5, size=2) +
 labs(x = "Name", y = "Gender", title = 'Main Titile', subtitle = 'Sub Title')
ggsave('Simpsons3.png')



