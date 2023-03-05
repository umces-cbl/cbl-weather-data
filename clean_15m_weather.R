data_log <- read.csv('cbl_weather_15min.csv')

data_log <- unique(data_log)

write.table(data_log,
            file = 'cbl_weather_15min_clean.csv',
            row.names = F,
            sep = ',')
