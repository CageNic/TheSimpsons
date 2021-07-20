###########################################
# data table create a column using ifelse #
###########################################

# Calculate Simpsons episodes by decade
# back ticks used to create multiple columns (in conjunction with =)


require(data.table)

my_data <- fread("/home/alice/R/simpsons_data.csv",
		 select = c('title', 'summary', 'original_air_date'))
str(my_data)

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
