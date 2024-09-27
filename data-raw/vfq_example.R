## code to prepare `vfq_example` dataset goes here

library(tidyverse)
library(readxl)

fn <- here::here("data-raw", "vfq_example.xlsx")

vfq_example <- readxl::read_xlsx(fn)

usethis::use_data(vfq_example, overwrite = TRUE)
