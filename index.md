---
title       : Estimated Water Consumption
subtitle    : An interactive demonstration for the "Developing Data Products" course
author      : Nick Doylend | Research Associate
job         : Centre for Renewable Energy Systems Technology (CREST)
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow
widgets     : mathjax
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- &twocol <!-- this won't compile within RStudio, use slidify("index.Rmd") on the console instead -->

## Introduction

This Slidify presentation describes the estimation of hot water consumption in offices, implemented in Shiny as a simple probabilistic model. 

*** =left

The estimation is based on three uncertain variables:
  1. Floor area
  2. Occupancy density
  3. Individual consumption

<style>
em {
  font-style: italic
}
</style>

_It's more complicated but this is a good starting point!_

*** =right

![Model Diagram](dhw_model.png)

---

## Deterministic calculation

A single point estimate of daily hot water consumption is easily obtained by first dividing the floor area $\mathrm{m^2}$ by the specific occupancy $\mathrm{m^2/person}$ to obtain the total number of occupants. This figure is then multiplied by the individual consumption $\mathrm{l/(person.day)}$ to obtain the daily consumption $\mathrm{l/day}$.


```r
floor_area <- 500 # m2
specific_occupancy <- 15 # m2/person
individual_consumption <- 10 # l/(person.day)

total_occupancy <- floor_area / specific_occupancy
daily_consumption <- total_occupancy * individual_consumption

daily_consumption # l/day
```

```
## [1] 333.3333
```

In this example, the daily consumption is 333.3 l/day.

---

## Probabilistic calculation

Let's say we're not sure about the input data and the true values will actually be in a range between a maximum and minimum value.

Parameter | Most likely | Minimum | Maximum 
----------|-------------|---------|---------
Floor area $\mathrm{m^2}$ | 500 | 400 | 600
Specific occupancy $\mathrm{m^2/person}$ | 15 | 8 | 16
Individual consumption $\mathrm{l/(person.day)}$ | 10 | 8 | 14


<br />
We can use the [triangular distribution](http://en.wikipedia.org/wiki/Triangular_distribution) to represent the range and most likely value of the input parameters.

If we randomly sample a large number of points from these distributions and calculate a daily consumption for each set of samples we obtain an output distribution that reflects the probability distribution of the inputs. This is the fundamental basis of the [Monte Carlo method](http://en.wikipedia.org/wiki/Monte_Carlo_method).

--- &twocol

## Summary

*** =left

### Probabilistic calculation

Instead of providing a single point estimate, the probabilistic calculation produces a distribution of likely values, based on the uncertainty in the input data.

<img src="assets/fig/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" height="350px" style="display: block; margin: auto;" />

*** =right

### Shiny application

The shiny application provides an interactive demonstration of the probabilistic calculation. The user can adjust the input parameters and see the effect on the output distribution. The user can also adjust the size of the random samples to see the effect on the shape of the distributions.

The shiny application can be found [here](http://ndoylend.shinyapps.io/Coursera_DevDataProd/).

