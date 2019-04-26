#Private Function
#Function that takes in probability and verifies that
#it is between 0 and 1.
#Returns TRUE if so and FALSE otherwise
check_prob <- function(prob) {
  if (prob < 0 | prob > 1) {
    stop("invalid prob value")
  }
  TRUE
}

#Private Function
#Function that takes in trials and verifies that it is
#a non negative integer.
#Returns TRUE if so and FALSE otherwise
check_trials <- function(trials) {
  if (!is.numeric(trials)) {
    stop("invalid trials value, must be a non negative integer")
  }
  else if (trials%%1!=0 | trials <= 0) {
    stop("invalid trials value, must be a non negative integer")
  }
  TRUE
}


#Private Function
#Function that takes in success and trials and makes sure that
#success is a non negative integer vector that is not greater than
#trials, or negative.
#Returns TRUE if so and FALSE otherwise
check_success <- function(success, trials) {
  if (!is.numeric(success)) {
    stop("success must be a non negative integer vector")
  }
  else if (sum(success%%1) != 0) {
    stop("success must be a non negative integer vector")
  }
  else if (sum(!(success <= trials) == TRUE) > 0) {
    stop("success cannot be greater than trials")
  }
  else if (sum(!(success >= 0) == TRUE) > 0) {
    stop("success cannot be negative")
  }
  TRUE
}





