print("top of the file")



install.packages("readr")
install.packages("dplyr")
install.packages('httr')
install.packages("stringr")
install.packages("twitteR")
install.packages("jsonlite")

# install.package("ggplot2")
print("after the installation")

library(httr)
library(jsonlite)
# library(tibble)
library(twitteR)
library(stringr)

print("afterloading")
# setwd("projects/gh-pfdbot")
# getwd()

print("after the libraryesi")



# setwd("projects/alaskacam")



DOT_KEY <- Sys.getenv("DOT_KEY")


url <- str_glue("https://511.alaska.gov/api/v2/get/cameras?key={DOT_KEY}")



# camera_data <- httr::GET(url)
# camera_content <- content(camera_data)
# camera_unlisted <- lapply(camera_content, unlist)


camera_json <- fromJSON(url)
cameras <- camera_json

# camera_df <- as.data.frame(camera_content)
# camera_df <- as.data.frame(do.call(rbind, unlist(camera_content)))
# camera_df <- as.data.frame(do.call(rbind, camera_content))
# camera_df <- as.data.frame(do.call(rbind, camera_unlisted))

# cameras <- cameras %>% filter (nchar(Url) > 0)


# str(camera_content)
# 
number_of_cameras <- nrow(cameras)
random_number <- floor( runif(1)*number_of_cameras)


camera_to_tweet <- cameras[random_number ,]

download.file(url= camera_to_tweet$Url, "pic.jpg")
info <- file.info("pic.jpg")
info$size


camera_tweet <- str_glue("The view from {camera_to_tweet$Name} taken at {camera_to_tweet$LastUpdated}. 📷 from 511.alaska.gov") 

camera_tweet

#############twitter stuff#########################


CONSUMER_KEY <- Sys.getenv("CONSUMER_KEY")
CONSUMER_SECRET <- Sys.getenv("CONSUMER_SECRET")
ACCESS_TOKEN <- Sys.getenv("ACCESS_TOKEN")
SECRET_KEY <- Sys.getenv("SECRET_KEY")


c_key_length <- nchar(CONSUMER_KEY)
c_s_key_length <- nchar(CONSUMER_SECRET)
a_t_key_length <- nchar(ACCESS_TOKEN)
s_k_key_length <- nchar(SECRET_KEY)


print("now setting up")

options(httr_oauth_cache=F)

setup_twitter_oauth(consumer_key = CONSUMER_KEY,
                    consumer_secret = CONSUMER_SECRET,
                    access_token = ACCESS_TOKEN,
                    access_secret = SECRET_KEY)
# 1


print("setup complete")
tweet(camera_tweet, mediaPath = "pic.jpg", bypassCharLimit=T)


######









