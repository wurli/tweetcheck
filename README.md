
# tweetcheck

{tweetcheck} is a simple R wrapper for the
[twitter-text](https://github.com/twitter/twitter-text) JavaScript
library which is made available by Twitter under the Apache 2.0 license.
This library allows easy parsing of tweet text as well as autolinking
and extraction of mentions.

# Demo

## Parse tweet information

``` r
library(tweetcheck)

tweets <- c(
  "This is a first tweet. Simple!",
  "This tweet tags @hadleywickham and @_wurli",
  "This tweet links {rtweet}: https://docs.ropensci.org/rtweet/",
  "Emojis take up two characters 😄😄😄",
  "Some may have hashtags or cashtags: #RStats $RSTATS",
  strrep("This tweet is way too long! ", 20)
)

tweet_info(tweets)
```

    ## # A tibble: 6 × 8
    ##   tweet                  weigh…¹ is_va…² permi…³ valid…⁴ valid…⁵ displ…⁶ displ…⁷
    ##   <chr>                    <int> <lgl>     <dbl>   <int>   <int>   <int>   <int>
    ## 1 "This is a first twee…      30 TRUE      0.107       1      30       1      30
    ## 2 "This tweet tags @had…      42 TRUE      0.15        1      42       1      42
    ## 3 "This tweet links {rt…      50 TRUE      0.178       1      60       1      60
    ## 4 "Emojis take up two c…      36 TRUE      0.128       1      36       1      36
    ## 5 "Some may have hashta…      51 TRUE      0.182       1      51       1      51
    ## 6 "This tweet is way to…     560 FALSE     2           1     280       1     560
    ## # … with abbreviated variable names ¹​weighted_length, ²​is_valid, ³​permillage,
    ## #   ⁴​valid_range_start, ⁵​valid_range_end, ⁶​display_range_start,
    ## #   ⁷​display_range_end

## Extract mentions

``` r
tweet_get_mentions(tweets)
```

    ## [[1]]
    ## character(0)
    ## 
    ## [[2]]
    ## [1] "hadleywickham" "_wurli"       
    ## 
    ## [[3]]
    ## character(0)
    ## 
    ## [[4]]
    ## character(0)
    ## 
    ## [[5]]
    ## character(0)
    ## 
    ## [[6]]
    ## character(0)

## Perform autolinking

``` r
tweet_autolink(tweets)
```

    ## [1] "This is a first tweet. Simple!"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    ## [2] "This tweet tags @<a class=\"tweet-url username\" href=\"https://twitter.com/hadleywickham\" data-screen-name=\"hadleywickham\" rel=\"nofollow\">hadleywickham</a> and @<a class=\"tweet-url username\" href=\"https://twitter.com/_wurli\" data-screen-name=\"_wurli\" rel=\"nofollow\">_wurli</a>"                                                                                                                                                                                                                                                                              
    ## [3] "This tweet links {rtweet}: <a href=\"https://docs.ropensci.org/rtweet/\" rel=\"nofollow\">https://docs.ropensci.org/rtweet/</a>"                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    ## [4] "Emojis take up two characters 😄😄😄"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    ## [5] "Some may have hashtags or cashtags: <a href=\"https://twitter.com/search?q=%23RStats\" title=\"#RStats\" class=\"tweet-url hashtag\" rel=\"nofollow\">#RStats</a> <a href=\"https://twitter.com/search?q=%24RSTATS\" title=\"$RSTATS\" class=\"tweet-url cashtag\" rel=\"nofollow\">$RSTATS</a>"                                                                                                                                                                                                                                                                                 
    ## [6] "This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! "

# See also

{rtweet} is a package which allows easy interaction with the Twitter API
for actions such as posting or downloading of tweets. {V8} is a package
which allows JavaScript code to be called from R and is used by
{tweetcheck}.
