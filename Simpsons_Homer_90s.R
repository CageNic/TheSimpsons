###########################################
# data table create a column using ifelse #
###########################################

###############################################
# added visual outputs with ggplot and ggsave #
###############################################

# Calculate Simpsons episodes by decade
# back ticks used to create multiple columns (in conjunction with =)


require(data.table)
require(ggplot2)
require(dplyr)

my_data <- fread('/home/alice/R/simpsons_data.csv', fill = TRUE, na.strings = "",
                  select = c('title', 'summary', 'original_air_date')
                )

# change original_air_date column from IDate to Date data type

my_data$original_air_date <- as.Date(my_data$original_air_date)

#--------------------#
# create new columns #
#--------------------#

# split the date into year month day columns
# date is already ISO formatted for R

my_data[, `:=` (year  = format(original_air_date, format = "%Y") ,
                month = format(original_air_date, format = "%m"),
                day   = format(original_air_date, format = "%d"))
                ]

my_data[, decade := ifelse(year < 1989, 'No Simpsons before 1989 - unless Tracy Ulman Show',
                    ifelse(year == 1989, ' Eighties',
                    ifelse(year >= 1990 & year <= 1999, 'Nineties',
                    ifelse(year >= 2000 & year <= 2009, 'Noughties',
                    ifelse(year >= 2010 & year <= 2019, 'Tens',
                    ifelse(year >= 2020, 'Twenties',
                    'Something Else')
  # catch all else that doesn't fit  )
                                      )
                                       )
                                        )
                                         )
                                          )
                                           ]

# using .N - contains the number of rows
# use with by = to count number of rows per decade

my_data[, .N, by = decade]

#------------------------------------------------------------------------#
# get rid of missing data across data table with complete.cases function #
#------------------------------------------------------------------------#

simpsons_complete <- my_data[complete.cases(my_data), ]

#---------------------------------------------------#
# ggplot with Base R                                # 
# plot an x axis (no y axis)                        #
# an x axis with a bar plot sums the y axis         #
# the y axis                                        #
# must use the word 'data' - can't use own variable #
#---------------------------------------------------#

ggplot(data = simpsons_complete) + geom_bar(mapping = aes(x = decade, color = decade))
ggsave('Simpsons1.png')

ggplot(data = simpsons_complete) + geom_bar(mapping = aes(x = decade, fill = decade))
ggsave('Simpsons2.png')

################################################################
# ggplot dplyr for x and y axis charts / plots - easier syntax #
################################################################

simpsons_complete %>%
  ggplot(aes(original_air_date, decade, color = decade)) +
 geom_point(alpha=0.5, size=2) +
 labs(x = "original_air_date", y = 'decade', title = 'Main Titile', subtitle = 'Sub Title')
ggsave('Simpsons3.png')
