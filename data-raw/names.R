## code to prepare `names` dataset goes here

raw_names <- c(
  "VFQ01", "VFQ02", "VFQ03", "VFQ04", "VFQ05",
  "VFQ06", "VFQ07", "VFQ08", "VFQ09", "VFQ10",
  "VFQ11", "VFQ12", "VFQ13", "VFQ14", "VFQ15",
  "VFQ15a", "VFQ15b", "VFQ15c", "VFQ16", "VFQ16a",
  "VFQ17", "VFQ18", "VFQ19", "VFQ20", "VFQ21",
  "VFQ22", "VFQ23", "VFQ24", "VFQ25"
)

evaluated_names <- c(
  "sVFQ01", "sVFQ02", "sVFQ03", "sVFQ04", "sVFQ05", "sVFQ06",
  "sVFQ07", "sVFQ08", "sVFQ09", "sVFQ10", "sVFQ11", "sVFQ12",
  "sVFQ13", "sVFQ14", "sVFQ15c", "sVFQ16", "sVFQ16a", "sVFQ17",
  "sVFQ18", "sVFQ19", "sVFQ20", "sVFQ21", "sVFQ22", "sVFQ23",
  "sVFQ24", "sVFQ25"
)

score_names <- c(
  "general_health", "general_vision",
  "ocular_pain", "near_activities",
  "distance_activities", "vs_social_functioning",
  "vs_mental_health", "vs_role_difficulties",
  "vs_dependency", "driving",
  "color_vision", "peripheral_vision"
)

usethis::use_data(raw_names, evaluated_names, score_names,
                  overwrite = TRUE, internal = TRUE)
