#Private Function
#Function that takes in trials and prob for a binomial distribution and
#calculates/returns the expected value
aux_mean <- function(trials, prob) {
  trials*prob
}

#Private Function
#Function that takes in trials and prob for a binomial distribution and
#calculates/returns the variance
aux_variance <- function(trials, prob) {
  (trials*prob)*(1-prob)
}

#Private Function
#Function that takes in trials and prob for a binomial distribution and
#calculates/returns the mode, or most common number(s). Could be 2 numbers
#in which case returned vector is of length 2.
aux_mode <- function(trials, prob) {
  val <- trials*prob + prob
  if (val%%1 == 0) {
    return (c(floor(val), floor(val)-1))
  }
  return (c(floor(val)))
}

#Private Function
#Function that takes in trials and prob for a binomial distribution and
#calculates/returns the calculated skewness
aux_skewness <- function(trials, prob) {
  (1-2*prob)/sqrt((trials*prob)*(1-prob))
}

#Private Function
#Function that takes in trials and prob for a binomial distribution and
#calculates/returns the calculated kurtosis
aux_kurtosis <- function(trials, prob) {
  (1-6*prob*(1-prob))/((trials*prob)*(1-prob))
}
