# Change working Directory to Desktop
setwd("C:/Users/usha/Desktop")
install.packages("ROAuth")
install.packages("streamR")
install.packages("twitteR")
install.packages("rjson")
library('RCurl')
library('ROAuth')
library('streamR')
library('twitteR')

# Download the certification file need for authentication 
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

# Create a file to collect all the twitter data in json
outFile <- "tweets_sample.json"

# Twitter Configuration
# Set all the parameters requires for authentication
requestURL       <- "https://api.twitter.com/oauth/request_token"
accessURL        <- "https://api.twitter.com/oauth/access_token"
authURL          <- "https://api.twitter.com/oauth/authorize"
consumerKey      <- "VCFmE9dOvSEMYcpNqlxAJDKIU"                                                                                   
consumerSecret   <- "CwbAGkDyo33c3hESEHAvTzg8XKJ1oQwE412QmDuOwDgsoyPfjo"                                                                                   
accessToken      <- "2415708067-YEBSfmyyi1ZEFp07GJtDalG748sC43wi8vC5NNn"
accessTokenSecret<- "xEAYE65O3PoFvWW6xoV4q1cWnfDufWSPHD6wmFRr9xsPv"

# Obtain oauth by handshaking 
my_oauth <- OAuthFactory$new( consumerKey=consumerKey,
                              consumerSecret=consumerSecret,
                              requestURL=requestURL,
                              accessURL=accessURL, 
                              authURL=authURL)

my_oauth$handshake(cainfo="cacert.pem")

# After execution of above code, we get a link to authorize aor application
# and then generate a pin number. Use the use pin number in console.

# set up the OAuth credentials for a twitterR session
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

# Opens the connections and start reading tweets
sampleStream( file=outFile, oauth=my_oauth, tweets=100 )

# More filter is applied to get the tweets

follow   <- ""  
track    <- "Boston,RedSoxs"  
location <- c(23.786699, 60.878590, 37.097000, 77.840813)  
filterStream( file.name=outFile, follow=follow, track=track, 	locations=location, oauth=my_oauth, timeout=5)
