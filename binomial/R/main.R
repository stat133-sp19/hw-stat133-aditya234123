#' @title bin_choose
#' @description calculates number of ways k successs can occur in n trials
#' @param n number of trials
#' @param k number of successes
#' @return number of ways k success can occur in n trials
#' @export
#' @examples
#' bin_choose(5, 2)
bin_choose <- function(n, k) {
  if (sum((k>n) == TRUE) > 0) {
    stop("k cannot be greater than n")
  }
  factorial(n) / (factorial(k)*factorial(n-k))
}

#' @title bin_probability
#' @description calculates the probability of getting a certain number of success
#' in a certain amount of trials, given a certain probability of success, for binomail
#' distributions.
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probability of getting success number of successes in trials number of trials,
#' given prob probability of success.
#' @export
#' @examples
#' bin_probability(2, 5, 0.5)
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  bin_choose(trials, success)*(prob^success)*((1-prob)^(trials-success))
}

#' @title bin_distribution
#' @description calculates the binomial distribution given the number of trials
#' and probability of success
#' @param trials number of trials
#' @param prob probability of success
#' @return data frame of the binomial distribution
#' @export
#' @examples
#' bin_distribution(5, 0.5)
bin_distribution <- function(trials, prob) {
  df <- data.frame('success'=0:trials, 'probability'=bin_probability(0:trials, trials, prob))
  class(df) <- c("bindis", "data.frame")
  df
}

#' @export
plot.bindis <- function(x, ...) {
  ggplot2::ggplot(x) +
    ggplot2::geom_bar(ggplot2::aes(x=x$success, y=x$probability), stat='identity') +
    ggplot2::xlab("Successes") +
    ggplot2::ylab("Probability")
}

#' @title bin_cumulative
#' @description calculates the binomial distribution, along with the cumulative
#' probability of the distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return data frame of the distribution and cumulative probability
#' @export
#' @examples
#' bin_cumulative(5, 0.5)
bin_cumulative <- function(trials, prob) {
  probs <- bin_probability(0:trials, trials, prob)
  df <- data.frame("success"=0:trials, "probability"=probs, "cumulative"=cumsum(probs))
  class(df) <- c("bincum", "data.frame")
  df
}

#' @export
plot.bincum <- function(x, ...) {
  ggplot2::ggplot(x) + ggplot2::geom_line(ggplot2::aes(x=x$success, y=x$cumulative)) +
    ggplot2::xlab("Successes") +
    ggplot2::ylab("Probability")
}

#' @title bin_variable
#' @description create a binvar object which has useful methods such as print
#' and summary which provide a lot of informaton.
#' @param trials number of trials
#' @param prob probability of success
#' @return binvar object
#' @export
#' @examples
#' bin_variable(5, 0.5)
bin_variable <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  obj <- list(
    trials=trials,
    prob=prob
  )
  class(obj) <- c("binvar", "list")
  obj
}

#' @export
print.binvar <- function(x, ...) {
  cat('"Binomial Variable"\n\n')
  cat("Parameters\n")
  cat(sprintf('- number of trials: %s', x$trials), "\n")
  cat(sprintf('- prob of success: %s', x$prob))
}

#' @export
summary.binvar <- function(object, ...) {
  l <- list(
    trials=object$trials,
    prob=object$prob,
    mean=aux_mean(object$trials, object$prob),
    variance=aux_variance(object$trials, object$prob),
    mode=aux_mode(object$trials, object$prob),
    skewness=aux_skewness(object$trials, object$prob),
    kurtosis=aux_kurtosis(object$trials, object$prob)
  )
  class(l) <- c("summary.binvar", "list")
  l
}

#' @export
print.summary.binvar <- function(x, ...) {
  cat('"Summary Binomial"\n\n')
  cat("Parameters\n")
  cat(sprintf('- number of trials: %s', x$trials), "\n")
  cat(sprintf('- prob of success: %s', x$prob), "\n\n")
  cat("Measures\n")
  cat(sprintf('- mean    : %s', x$mean), "\n")
  cat(sprintf('- variance: %s', x$variance), "\n")
  cat(sprintf('- mode    : %s', x$mode), "\n")
  cat(sprintf('- skewness: %s', x$skewness), "\n")
  cat(sprintf('- kurtosis: %s', x$kurtosis), "\n")
}

#' @title bin_mean
#' @description calulates the expected value of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return expected value of binomial distribution described by parameters
#' @export
#' @examples
#' bin_mean(5, 0.5)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mean(trials, prob)
}

#' @title bin_variance
#' @description calulates the variance of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return variance of binomial distribution described by parameters
#' @export
#' @examples
#' bin_variance(5, 0.5)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_variance(trials, prob)
}

#' @title bin_mode
#' @description calulates the mode, or most likely number of successes, of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return mode of binomial distribution described by parameters. Could
#' be a vector of length 2 or 1 depending on how many most likely number of
#' successes there are.
#' @export
#' @examples
#' bin_mode(5, 0.5)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mode(trials, prob)
}

#' @title bin_skewness
#' @description calulates the skewness value of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return skewness value of binomial distribution described by parameters
#' @export
#' @examples
#' bin_skewness(5, 0.5)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_skewness(trials, prob)
}

#' @title bin_kurtosis
#' @description calulates the kurtosis value of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return kurtosis value of binomial distribution described by parameters
#' @export
#' @examples
#' bin_kurtosis(5, 0.5)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_kurtosis(trials, prob)
}
