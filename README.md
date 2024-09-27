
# VFQ

<!-- badges: start -->
<!-- badges: end -->

The goal of VFQ is to facilitate scoring of 
the VFQ-25 Questionnaire 
(The National Eye Institute 25-Item Visual Function Questionnaire).

## Installation

You can install the development version of `vfq` like so:

``` r
# Install devtools package if necessary
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")

# Install the stable verion from GitHub
devtools::install_github("jirilukavsky/vfq")

```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(vfq)
data("vfq_example")

results <- 
  vfq_example |> 
  vfq::evaluate_raw_data() |> 
  vfq::evaluate_scores()
```

