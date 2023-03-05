library(rvest)

dat <- read_html('https://facwebsrv1.cbl.umces.edu/weather/daily.htm')

df <- dat |>
  html_element(xpath = '/html/body/pre[7]') |> 
  html_text()

data_date <- read.table(text = df,
                        nrows = 1)
data_body <- read.table(text = df,
                        skip = 3)

names(data_body) <-
  c('time', 'wind_dir_deg', 'wind_spd_mph', 'wind_gust_mph', 'humidity_pct',
    'temp_f', 'raw_barom_in', 'tot_rain_in', 'uv', 'solar_w.sqm', 'wind_chill_f',
    'dew_point_f', 'barom_sl_in', 'cloud_base_ft', 'rain_rate_in_hr')

data_body <- cbind(
  data.frame(date = rep(data_date[[1]], nrow(data_body))),
  data_body
)

if(file.exists('cbl_weather_15min.csv')){
  write.table(data_body,
              file = 'cbl_weather_15min.csv',
              append = T,
              col.names = F,
              row.names = F)
}else{
  write.table(data_body,
              file = 'cbl_weather_15min.csv',
              row.names = F)
}


# References:
# https://www.rforseo.com/ressources/launch-an-r-script-using-github-actions

# https://beamilz.com/posts/series-gha/2022-series-gha-2-creating-your-first-action/en/
