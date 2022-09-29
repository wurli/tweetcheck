
#' Wrappers from the twitter-text library
#'
#' @param x A character vector of tweets
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
  lapply(x, function(x) .ct$call("twttr.txt.parseTweet", x))
}

#' @rdname tweet_info
#' @export
tweet_permillage <- function(x) {
  out <- tweet_info(x)
  vapply(out, function(x) x$permillage, integer(1))
}

#' @rdname tweet_info
#' @export
tweet_length <- function(x) {
  out <- tweet_info(x)
  vapply(out, function(x) x$weightedLength, integer(1))
}

#' @rdname tweet_info
#' @export
tweet_is_valid <- function(x) {
  out <- tweet_info(x)
  vapply(out, function(x) x$valid, logical(1))
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