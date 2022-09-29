
# Twitter-text demo

This repo gives a basic example of how
[twitter-text](https://github.com/twitter/twitter-text) could be wrapped
by an R package using {V8}.

``` r
tweets <- c(
  "This is a first tweet. Simple!",
  "This tweet tags @hadleywickham and @_wurli",
  "This tweet links {rtweet}: https://docs.ropensci.org/rtweet/",
  strrep("This tweet is way too long! ", 20)
)
```

## Get all info for each tweet

``` r
# Only two used because it's a bit lengthy
tweet_info(tweets[1:2])
```

    ## [[1]]
    ## [[1]]$weightedLength
    ## [1] 30
    ## 
    ## [[1]]$valid
    ## [1] TRUE
    ## 
    ## [[1]]$permillage
    ## [1] 107
    ## 
    ## [[1]]$validRangeStart
    ## [1] 0
    ## 
    ## [[1]]$validRangeEnd
    ## [1] 29
    ## 
    ## [[1]]$displayRangeStart
    ## [1] 0
    ## 
    ## [[1]]$displayRangeEnd
    ## [1] 29
    ## 
    ## 
    ## [[2]]
    ## [[2]]$weightedLength
    ## [1] 42
    ## 
    ## [[2]]$valid
    ## [1] TRUE
    ## 
    ## [[2]]$permillage
    ## [1] 150
    ## 
    ## [[2]]$validRangeStart
    ## [1] 0
    ## 
    ## [[2]]$validRangeEnd
    ## [1] 41
    ## 
    ## [[2]]$displayRangeStart
    ## [1] 0
    ## 
    ## [[2]]$displayRangeEnd
    ## [1] 41

## Get tweet permillage

``` r
tweet_permillage(tweets)
```

    ## [1]  107  150  178 2000

## Get tweet length

``` r
tweet_length(tweets)
```

    ## [1]  30  42  50 560

This is not the same as the number of chars!

``` r
tweet_length(tweets) == nchar(tweets)
```

    ## [1]  TRUE  TRUE FALSE  TRUE

## Check for tweet validity

``` r
tweet_is_valid(tweets)
```

    ## [1]  TRUE  TRUE  TRUE FALSE

## Get mentions

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

## Perform autolinking

``` r
tweet_autolink(tweets)
```

    ## [1] "This is a first tweet. Simple!"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    ## [2] "This tweet tags @<a class=\"tweet-url username\" href=\"https://twitter.com/hadleywickham\" data-screen-name=\"hadleywickham\" rel=\"nofollow\">hadleywickham</a> and @<a class=\"tweet-url username\" href=\"https://twitter.com/_wurli\" data-screen-name=\"_wurli\" rel=\"nofollow\">_wurli</a>"                                                                                                                                                                                                                                                                              
    ## [3] "This tweet links {rtweet}: <a href=\"https://docs.ropensci.org/rtweet/\" rel=\"nofollow\">https://docs.ropensci.org/rtweet/</a>"                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    ## [4] "This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! This tweet is way too long! "
