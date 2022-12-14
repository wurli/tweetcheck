% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/twitter-text.R
\name{tweet_get_mentions}
\alias{tweet_get_mentions}
\title{Extract mentions from a tweet}
\usage{
tweet_get_mentions(x)
}
\arguments{
\item{x}{A character vector of tweets to extract mentions for}
}
\value{
A list with \code{length(x)} elements, where each element is a character
vector of mentions. Mentions have the '@' character removed.
}
\description{
Extract mentions from a tweet
}
\examples{
tweet_get_mentions(c("No mentions", "One mention @_wurli"))
}
