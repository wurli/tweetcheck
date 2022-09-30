

#' Parse a tweet
#' 
#' This function can be used to produce all parse information for a tweet
#'
#' @param x A character vector of tweet
#' 
#' @return A dataframe with the following columns:
#'   * `tweet`: The original tweet text
#'   * `weighted_length`: The length of the tweet according to Twitter's 
#'     parsing rules
#'   * `is_valid`: Whether or not `tweet` is postable according to Twitter's
#'     parsing rules
#'   * `permillage`
#'
#' @export
#'
#' @examples
#' tweets <- c(
#'   "This is a first tweet. Simple!",
#'   "This tweet tags @hadleywickham and @_wurli",
#'   "This tweet links {rtweet}: https://docs.ropensci.org/rtweet/",
#'   strrep("This tweet is way too long! ", 20)
#' )
#' 
#' tweet_info(tweets)
#' tweet_permillage(tweets)
#' tweet_length(tweets)
#' tweet_is_valid(tweets)
#' tweet_get_mentions(tweets)
#' tweet_autolink(tweets)
tweet_info <- function(x) {
  
  out <- lapply(x, function(x) .ct$call("twttr.txt.parseTweet", x))
  out <- do.call(rbind, out)
  
  colnames(out) <- c(
    "weighted_length", "is_valid", "permillage", "valid_range_start",
    "valid_range_end", "display_range_start", "display_range_end"
  )
  
  cbind(
    data.frame(tweet = x, stringsAsFactors = FALSE),
    out
  )
  
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
  out <- tweet_info(x)
  vapply(out, function(x) x$valid, logical(1))
}

#' @export
tweet_valid_range_start <- function(x) {
  tweet_info(x)$valid_range_start
}

#' @export
tweet_valid_range_end <- function(x) {
  tweet_info(x)$valid_range_end
}

#' @export
tweet_display_range_start <- function(x) {
  tweet_info(x)$tweet_display_range_start
}

#' @export
tweet_display_range_end <- function(x) {
  tweet_info(x)$tweet_display_range_end
}

#' @rdname tweet_info
#' @export
tweet_get_mentions <- function(x) {
  lapply(x, function(x) {
    out <- .ct$call("twttr.txt.extractMentions", x)
    if (length(out) > 0) out else character()
  })
}

#' @rdname tweet_info
#' @export
tweet_autolink <- function(x) {
  vapply(x, function(x) .ct$call("twttr.txt.autoLink", x), character(1), USE.NAMES = FALSE)
}