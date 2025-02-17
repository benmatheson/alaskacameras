print("top of the file")


# setwd("projects/alaskacam")

install.packages("readr")
install.packages("dplyr")
install.packages('httr')
install.packages("stringr")
# install.packages("twitteR")
# devtools::install_github("jrowen/twitteR", ref = "oauth_httr_1_0")

install.packages("jsonlite")
install.packages('bskyr')
# install.packages('pak')

# install.package("ggplot2")
print("after the installation")

# library(httr)
library(jsonlite)
# library(tibble)
# library(twitteR)
library(stringr)
# library(pak)
library(bskyr)
library(dplyr)

# pak::pak('christopherkenny/bskyr')


print("afterloading")

print("after the library")


DOT_KEY <- Sys.getenv("DOT_KEY")


# url <- str_glue("https://511.alaska.gov/api/v2/get/cameras?key={DOT_KEY}")
url <- str_glue("https://511.alaska.gov/api/v2/get/cameras?key={DOT_KEY}")




camera_json <- fromJSON(url)
cameras <- camera_json


cameras <- tidyr::unnest(camera_json, Views, names_sep = "_")

##rename for eventual json
cameras <- cameras %>% rename(Status = Views_Status, Url =Views_Url, RoadwayName = Roadway )

# 
number_of_cameras <- nrow(cameras)
random_number <- floor( runif(1)*number_of_cameras)


camera_to_tweet <- cameras[random_number ,]

download.file(url= camera_to_tweet$Url, "pic.jpeg")
info <- file.info("pic.jpeg")

if (info$size < 20000) {
  
  print("the file size is less than 20KB:")
  
  # print("the size is", info$size)
# stop()
  
  print("no more execution. no errors")
  } else {

    
    print("the file shoudl be more thank 20KB:")
    print(info$size)
    
    
camera_tweet <- str_glue("The view from {camera_to_tweet$Location}, 📷 from 511.alaska.gov") 

camera_tweet

#############twitter stuff#########################


BSKYPASS <- Sys.getenv("BSKYPASS")


print("now setting up")

options(httr_oauth_cache=F)


set_bluesky_user('alaskacameras.bsky.social')
set_bluesky_pass(BSKYPASS)


#####################################################################################################################################################################################################

image_blob <- bs_upload_blob("pic.jpeg", clean=FALSE)

#attempting blob

bs_post(
  text= camera_tweet,
  
  images = image_blob,
  
  images_alt = "a picture from alaska's 511 cameras located on highway"
  
)


# bs_post(
#   text = "a picture from alaska's 511 cameras",
#   images = c('pics/pic.jpeg'),
#   images_alt = "a picture from alaska's 511 cameras located on highway"
# 
#   
# )

#also works 
# 
# text = "a picture from alaska's 511 cameras",
# # images = c("img.png")
# # images = image_blob
# images = c('pics/pic.jpeg', 'pics/pic.jpeg'),
# images_alt = c("a picture from alaska's 511 cameras located on highways", "alt2")
# # images = c('pics/pic.jpeg', 'pics/pic.jpeg'),
# # images_alt = c("alt1", "alt2")
# # max_tries = 6

# works
# 
# bs_post(
#   text= '.',
# 
#   images = c('pics/pic.jpeg', 'pics/pic.jpeg'),
#   images_alt = c("alt1", "alt2")
# 
# )




  # images = "pic.jpeg"

}

######





