
The binomial package makes calculating probabilities for binomial random variables very simple. It also helps with related calculations such as the expected value, variance, mode, skewness and kurtosis.

<br>

This introduction will take you through each function to help you understand how to use it.

##Binomial Summary Measures:

### * bin_mean(*trials, prob*):

* This function is used to compute the mean, or expected value, of a binomial distribution with:
    * trials = number of trials
    * prob = probability of success
* It will return the mean

For example:

```{r}
bin_mean(10,0.3)
```

<br>

### * bin_variance(*trials, prob*)):

* This function is used to compute the variance of a binomial distribution with:
    * trials = number of trials
    * prob = probability of success
* It will return the variance
    
For example:

```{r}
bin_variance(10,0.3)
```
    
<br>

### * bin_mode(*trials, prob*)):
* This function is used to compute the mode of a binomial distribution with:
    * trials = number of trials
    * prob = probability of success
* The mode is the most likely number of successes out of all the trials.
* If there are two most likely number of successes, then this function will return a vector of both those numbers. Otherwise just a vector of one.

For example:

```{r}
bin_mode(10,0.3)
bin_mode(1,0.5)
```

<br>

### * bin_skewness(*trials, prob*)):

* This function is used to compute the skewness value of the binomial distribution with:
    * trials = number of trials
    * prob = probability of success

For example:

```{r}
bin_skewness(10,0.3)
```

<br>

### * bin_kurtosis(*trials, prob*)):

* This function is used to compute the kurtosis value of the binomial distribution with:
    * trials = number of trials
    * prob = probability of success

For example:

```{r}
bin_kurtosis(10,0.3)
```

<br>

##bin_choose(*n, k*):

* This function calculates the number of combinations in which *k* successes can occurr in *n* trials.

For example:

```{r}
bin_choose(5, 2)
```

* It will error if the number of successes is greater than the number of trials.
* The function is also vectorized and will work in these cases as well:

```{r}
bin_choose(5, 1:4)
```

<br>

##bin_probability(*success, trials, prob*):
  * This function calculates the probability of getting *success* number of successes in *trials* number of trials, given that the probability of success is *prob*.
  * It checks to ensure that probability is between 0 and 1, and that trials and success are both valid parameters for the binomial distribution.
  * Again this is also vectorized as seen below.

For example:

```{r}
bin_probability(2,5,0.5)
bin_probability(0:3,5,0.5)
```

<br>

##bin_distribution(*trials, prob*):

* This function calculates a binomial distribution given:
   * trials = number of trials
   * prob = probability of success
   
* It returns a data frame with 2 columns, success and probability, as seen below:

```{r}
bin_distribution(5, 0.5)
```

* This returned data frame's primary class is 'bindis'
* One of the methods that you can invoke on it is plot.bindis()
* It returns a barplot that displays the binomial probability distribution.

For example:

```{r}
plot(bin_distribution(5, 0.5))
```

<br>

##bin_cumulative(*trials, prob*):

* This function is similar to bin_probability()

* It also returns a data frame like bin_probability() but has an extra column that keeps track of the cumulative probablity.

For example:

```{r}
bin_cumulative(5, 0.5)
```

* The returned data frame's primary class in this case is 'bincum'.
* One of the methods that you can invoke on it is plot.bincum()
* It returns a line graph of the cumulative probablity over the distribution.

```{r}
plot(bin_cumulative(5, 0.5))
```

<br>

##bin_variable(*trials, prob*):

* Another function we have is bin_variable(). This basically returns an object of class 'binvar' which is a list of named elements:
    * trials: number of trials
    * prob: probability of success
    
* This is useful because the class 'binvar' has useful methods.
* One aesthetically pleasing thing is that it has a very clean print method.

```{r}
bin_variable(5, 0.5)
```

* Another more practical thing is it has a summary method which provides a lot of information about the binomial distribution effortlessly.

For example:

```{r}
summary(bin_variable(5, 0.5))
```


