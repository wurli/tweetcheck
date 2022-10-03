

#' Parse a tweet
#' 
#'  These functions can be used to validate tweets before posting.
#' 
#' * `tweet_info()`: `<tbl_df>` with columns for all the 
#'   following fields, as well as a column `tweet` giving the original text.
#'   Note that this function is called internally by all of the following,
#'   so it may be more efficient to store this result and extract columns as 
#'   needed.
#'  
#' * `tweet_permillage()`: `<numeric>` indicating the number of characters
#'   used as a proportion of the maximum number of characters allowed. I.e. 
#'   this will be > 0 and <= 1 for valid tweets.
#' 
#' * `tweet_weighted_length()`: `<integer>` indicating the 'length' of the tweet 
#'   according to Twitter's parsing rules. The maximum allowed length is 280 
#'   characters.
#' 
#' * `tweet_is_valid()`: `<logical>` indicating whether or not the tweet is
#'   valid according to Twitter's parsing rules
#' 
#' * `tweet_valid_range_start()`/`tweet_valid_range_end()`: `<integer>` 
#'   indicating the index of the first/last characters of the valid range of a 
#'   tweet
#' 
#' * `tweet_display_range_start()`/`tweet_display_range_end()`: `<integer>`
#'   indicating the index of the first/last characters of the display range of
#'   a tweet
#'
#' @param x A character vector of tweet
#' 
#' @return `tweet_info()` returns a dataframe with `length(x)` rows. The other
#'   functions return integer/numeric vectors with `length(x)` elements.
#'
#' @seealso [tweet_get_mentions()] and [tweet_autolink()]
#'
#' @export
#'
#' @examples
#' tweets <- c(
#'   "This is a first tweet. Simple!",
#'   "This tweet tags @hadleywickham and @_wurli",
#'   "This tweet links {rtweet}: https://docs.ropensci.org/rtweet/",
#'   "Emojis take up two characters \U1F600\U1F600\U1F600",
#'   strrep("This tweet is way too long! ", 20)
#' )
#' 
#' # Dataframe summarising all of the following
#' tweet_info(tweets)
#' 
#' # Ratio of used characterss to allowed characters
#' tweet_permillage(tweets)
#' 
#' # Length of the tweet (according to Twitter's rules):
#' tweet_weighted_length(tweets)
#' 
#' # Logical indicating tweet validity:
#' tweet_is_valid(tweets)
#' 
#' # Valid range of a tweet
#' tweet_valid_range_start(tweets)
#' tweet_valid_range_end(tweets)
#' 
#' # Display range of a tweet
#' tweet_display_range_start(tweets)
#' tweet_display_range_end(tweets)
tweet_info <- function(x) {
  
  out <- lapply(x, function(x) as.data.frame(.ct$call("twttr.txt.parseTweet", x)))
  out <- do.call(rbind, out)
  
  colnames(out) <- c(
    "weighted_length", "is_valid", "permillage", "valid_range_start",
    "valid_range_end", "display_range_start", "display_range_end"
  )
  
  # More familiar to show this as a number between 0 and 1 for valid tweets
  out$permillage          <- out$permillage / 1000 
  
  # R indexes from 1 but JavaScript indexes from 0
  out$valid_range_start   <- out$valid_range_start + 1L
  out$valid_range_end     <- out$valid_range_end + 1L
  out$display_range_start <- out$display_range_start + 1L
  out$display_range_end   <- out$display_range_end + 1L
  
  tibble::as_tibble(cbind(
    data.frame(tweet = x, stringsAsFactors = FALSE),
    out
  ))
  
}

#' @rdname tweet_info
#' @export
tweet_permillage <- function(x) {
  tweet_info(x)$permillage
}

#' @rdname tweet_info
#' @export
tweet_weighted_length <- function(x) {
  tweet_info(x)$weighted_length
}

#' @rdname tweet_info
#' @export
tweet_is_valid <- function(x) {
  tweet_info(x)$is_valid
}

#' @rdname tweet_info
#' @export
tweet_valid_range_start <- function(x) {
  tweet_info(x)$valid_range_start
}

#' @rdname tweet_info
#' @export
tweet_valid_range_end <- function(x) {
  tweet_info(x)$valid_range_end
}

#' @rdname tweet_info
#' @export
tweet_display_range_start <- function(x) {
  tweet_info(x)$display_range_start
}

#' @rdname tweet_info
#' @export
tweet_display_range_end <- function(x) {
  tweet_info(x)$display_range_end
}


#' Extract mentions from a tweet
#'
#' @param x A character vector of tweets to extract mentions for
#'
#' @return A list with `length(x)` elements, where each element is a character 
#'   vector of mentions. Mentions have the '@@' character removed.  
#' 
#' @export
#'
#' @examples
#' tweet_get_mentions(c("No mentions", "One mention @@_wurli"))
tweet_get_mentions <- function(x) {
  lapply(x, function(x) {
    out <- .ct$call("twttr.txt.extractMentions", x)
    if (length(out) > 0) out else character()
  })
}


#' Perform tweet autolinking
#'
#' @param x A character vector of tweets to be autolinked
#'
#' @return A character vector giving the HTML which would be used by Twitter
#'   if `x` were posted as a tweet.
#'   
#' @export
#'
#' @examples
#' tweet_autolink(c(
#'   "Tweet with no links",
#'   "Tweet with a normal link: https://www.r-project.org",
#'   "Tweet with a mention @@hadleywickham",
#'   "Tweet with a hastag: #RStats",
#'   "Tweet with a cashtag: $RSTATS"
#' ))
tweet_autolink <- function(x) {
  vapply(x, function(x) .ct$call("twttr.txt.autoLink", x), character(1), USE.NAMES = FALSE)
}