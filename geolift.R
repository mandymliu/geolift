##installing packages & load data
#install.packages("remotes", repos='http://cran.us.r-project.org')
#remotes::install_github("ebenmichael/augsynth")
#remotes::install_github("facebookincubator/GeoLift")

library(GeoLift)
data(GeoLift_PreTest)

#Reading data
GeoTestData_PreTest <- GeoDataRead(data = GeoLift_PreTest,
                                   date_id = "date",
                                   location_id = "location",
                                   Y_id = "Y",
                                   X = c(), #empty list as we have no covariates
                                   format = "yyyy-mm-dd",
                                   summary = TRUE)

head(GeoLift_PreTest)

#get weights
weights <- GetWeights(Y_id = "Y",
                          location_id = "location",
                          time_id = "time",
                          data = GeoTestData_PreTest,
                          locations = c("austin"),
                          pretreatment_end_time = 90,
                          fixed_effects = TRUE)

##to exclude markets being considered in control
#exclude_markets <- c("honolulu","washington")
#GeoTestData_PreTest_Excl <- subset(GeoTestData_PreTest, !location %in% exclude_markets)

head(dplyr::arrange(weights, desc(weight)))

# download to csv
write.csv(weights, "/Users/mandyliu/Documents/R/geolift_weights.csv", row.names=FALSE)
write.csv(GeoLift_PreTest, "/Users/mandyliu/Documents/R/market_data.csv", row.names=FALSE)


