# recode rules
# Q: 1,3,4,15c
recode_template_1 <- function(v) {
  stopifnot(all(v %in% c(NA, 1:5)))
  r <- numeric(length(v))
  r[v == 1] <- 100
  r[v == 2] <- 75
  r[v == 3] <- 50
  r[v == 4] <- 25
  r[v == 5] <- 0
  r
}
# Q: 2
recode_template_2 <- function(v) {
  stopifnot(all(v %in% c(NA, 1:6)))
  r <- numeric(length(v))
  r[v == 1] <- 100
  r[v == 2] <- 80
  r[v == 3] <- 60
  r[v == 4] <- 40
  r[v == 5] <- 20
  r[v == 6] <- 0
  r
}
# Q: 5,6,7,8,9,10,11,12,13,14,16,16a
recode_template_3 <- function(v) {
  stopifnot(all(v %in% c(NA, 1:6)))
  r <- numeric(length(v))
  r[v == 1] <- 100
  r[v == 2] <- 75
  r[v == 3] <- 50
  r[v == 4] <- 25
  r[v == 5] <- 0
  r[v == 6] <- NA
  r
}
# Q: 17,18,19,20,21,22,23,24,25
recode_template_4 <- function(v) {
  stopifnot(all(v %in% c(NA, 1:5)))
  r <- numeric(length(v))
  r[v == 1] <- 0
  r[v == 2] <- 25
  r[v == 3] <- 50
  r[v == 4] <- 75
  r[v == 5] <- 100
  r
}

#' Evaluate VFQ raw data
#'
#' Adjusts scores for each item
#' (they differ based on the number of options).
#'
#' @param tab Tibble with correctly named columns
#'
#' @return Tibble with columns
#' \code{sVFQ01} to \code{sVFQ25} with values from 0 to 100.
#' Each row corresponds to one row in the input \code{tab}.
#' @export
#'
#' @examples
evaluate_raw_data <- function(tab) {
  res <- tibble::tibble(
    sVFQ01 = recode_template_1(tab$VFQ01),
    sVFQ02 = recode_template_2(tab$VFQ02),
    sVFQ03 = recode_template_1(tab$VFQ03),
    sVFQ04 = recode_template_1(tab$VFQ04),
    sVFQ05 = recode_template_3(tab$VFQ05),
    sVFQ06 = recode_template_3(tab$VFQ06),
    sVFQ07 = recode_template_3(tab$VFQ07),
    sVFQ08 = recode_template_3(tab$VFQ08),
    sVFQ09 = recode_template_3(tab$VFQ09),
    sVFQ10 = recode_template_3(tab$VFQ10),
    sVFQ11 = recode_template_3(tab$VFQ11),
    sVFQ12 = recode_template_3(tab$VFQ12),
    sVFQ13 = recode_template_3(tab$VFQ13),
    sVFQ14 = recode_template_3(tab$VFQ14),
    sVFQ15c = recode_template_1(tab$VFQ15c),
    sVFQ16 = recode_template_3(tab$VFQ16),
    sVFQ16a = recode_template_3(tab$VFQ16a),
    sVFQ17 = recode_template_4(tab$VFQ17),
    sVFQ18 = recode_template_4(tab$VFQ18),
    sVFQ19 = recode_template_4(tab$VFQ19),
    sVFQ20 = recode_template_4(tab$VFQ20),
    sVFQ21 = recode_template_4(tab$VFQ21),
    sVFQ22 = recode_template_4(tab$VFQ22),
    sVFQ23 = recode_template_4(tab$VFQ23),
    sVFQ24 = recode_template_4(tab$VFQ24),
    sVFQ25 = recode_template_4(tab$VFQ25)
  )
  res$sVFQ15c[tab$VFQ15b == 1] <- 0
  res$sVFQ15c[tab$VFQ15b == 2] <- NA
  res$sVFQ15c[tab$VFQ15b == 3] <- NA
  res
}

make_average <- function(tab) {
  res <- tab |> apply(1, mean, na.rm = T)
  res[is.nan(res)] <- NA
  res
}

#' Calculates VFQ scale scores
#'
#' @param stab Tibble obtained via \code{evaluate_raw_data}
#'
#' @return Tibble with 12 columns (\code{general_health} to \code{peripheral_vision})
#' @export
#'
#' @examples
evaluate_scores <- function(stab) {
  res <- tibble::tibble(
    general_health = stab$sVFQ01,
    general_vision = stab$sVFQ02,
    ocular_pain =
      make_average(stab |> dplyr::select("sVFQ04", "sVFQ19")),
    near_activities =
      make_average(stab |> dplyr::select("sVFQ05", "sVFQ06", "sVFQ07")),
    distance_activities =
      make_average(stab |> dplyr::select("sVFQ08", "sVFQ09", "sVFQ14")),
    vs_social_functioning =
      make_average(stab |> dplyr::select("sVFQ11", "sVFQ13")),
    vs_mental_health =
      make_average(stab |> dplyr::select("sVFQ03", "sVFQ21", "sVFQ22", "sVFQ25")),
    vs_role_difficulties =
      make_average(stab |> dplyr::select("sVFQ17", "sVFQ18")),
    vs_dependency =
      make_average(stab |> dplyr::select("sVFQ20", "sVFQ23", "sVFQ24")),
    driving =
      make_average(stab |> dplyr::select("sVFQ15c", "sVFQ16", "sVFQ16a")),
    color_vision = stab$sVFQ12,
    peripheral_vision = stab$sVFQ10
  )
  res
}

#' Check column names
#'
#' Checks if the column names are compatible with the processing functions
#' (\code{evaluate_raw_data}, \code{evaluate_scores}).
#'
#' Depending on the \code{type} value, it checks
#' \describe{
#'   \item{raw}{Can be input to \code{evaluate_raw_data}}
#'   \item{eval}{Can be input to \code{evaluate_scores}, can be output of \code{evaluate_raw_data}}
#'   \item{score}{can be output of \code{evaluate_scores}}
#'   ...
#' }
#'
#' @param tab Tibble to check
#' @param type One of "raw", "eval", "score"
#'
#' @return Logical indicating whether the column names are correct.
#' @export
#'
#' @examples
#' \dontrun{
#' data("vfq_example")
#' correct_naming(vfq_example, "raw")
#' }
correct_naming <- function(tab, type = "raw") {
  all_expected_names <- list(
    "raw" = raw_names,
    "eval" = evaluated_names,
    "score" = score_names
  )
  expected_names <- all_expected_names[[type]]
  if (is.null(expected_names)) stop("Type should be one of raw/eval/score")
  all(expected_names %in% colnames(tab))
}
