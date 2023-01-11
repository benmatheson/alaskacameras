print("top of the file")


# setwd("projects/alaskacam")

install.packages("readr")
install.packages("dplyr")
install.packages('httr')
install.packages("stringr")
# install.packages("twitteR")
# devtools::install_github("jrowen/twitteR", ref = "oauth_httr_1_0")

install.packages("jsonlite")
install.packages("rtweet")

# install.package("ggplot2")
print("after the installation")

# library(httr)
library(jsonlite)
# library(tibble)
# library(twitteR)
library(rtweet)
library(stringr)

print("afterloading")

print("after the library")


DOT_KEY <- Sys.getenv("DOT_KEY")

# url <- str_glue("https://511.alaska.gov/api/v2/get/cameras?key={DOT_KEY}")
url <- str_glue("https://511.alaska.gov/api/v2/get/cameras?key={DOT_KEY}")





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

if (info$size < 20000) {
  
  print("the file size is less than 20KB:")
  
  print(info$size)
# stop()
  
  print("no more execution. no errors")
  } else {


    
    print("the file shoudl be more thank 20KB:")
    print(info$size)
    
    
camera_tweet <- str_glue("The view from {camera_to_tweet$Name}, taken at {camera_to_tweet$LastUpdated}. 📷 from 511.alaska.gov") 

camera_tweet

#############twitter stuff#########################



CONSUMER_KEY <- Sys.getenv("CONSUMER_KEY")
CONSUMER_SECRET <- Sys.getenv("CONSUMER_SECRET")
ACCESS_TOKEN <- Sys.getenv("ACCESS_TOKEN")
SECRET_KEY <- Sys.getenv("SECRET_KEY")


# c_key_length <- nchar(CONSUMER_KEY)
# c_s_key_length <- nchar(CONSUMER_SECRET)
# a_t_key_length <- nchar(ACCESS_TOKEN)
# s_k_key_length <- nchar(SECRET_KEY)


# print("now setting up")

options(httr_oauth_cache=F)


#####################################################################################################################################################################################################


bot <- rtweet_bot(api_key = CONSUMER_KEY , api_secret =CONSUMER_SECRET,  access_token =ACCESS_TOKEN, access_secret = SECRET_KEY )

# bot1 <- rtweet_bot()
auth_as(bot)


# bear_auth <- rtweet_app()


# auth_as(bear)
# auth_get()

# auth_sitrep()


# status <- auth_sitrep()
# status

# auth_as(auth=bot)

# post_tweet(status = "test_auth_bot")

# auth_save(bentoken, "custom_token")
# auth_as("custom_token")

# auth_as("default")


# df <- search_tweets("#MiSTerFPGA")
# rt <- search_tweets("#rstats", n = 1000, include_rts = FALSE)


# auth_get()
# post_tweet(status = "testbot", token = bot)


# str(bot)
# str(bear)
# ?post_tweet("test1", token = bear)


#####################################################################################################################################################################################################



# 
# setup_twitter_oauth(consumer_key = CONSUMER_KEY,
#                     consumer_secret = CONSUMER_SECRET,
#                     access_token = ACCESS_TOKEN,
#                     access_secret = SECRET_KEY)
# 
# check_twitter_oauth()
# 1


# setup_twitter_oauth(consumer_key = CONSUMER_KEY,
#                     consumer_secret = CONSUMER_SECRET)
# 1


# ?setup_twitter_oauth


print("setup complete")
# tweet(camera_tweet, mediaPath = "pic.jpg", bypassCharLimit=T)


post_tweet(status = camera_tweet, media= "pic.jpg", token = bot, media_alt_text = "a view from a camera on one of Alaska's highways")

}

######









