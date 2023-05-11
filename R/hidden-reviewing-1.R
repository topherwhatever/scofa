#' @title Read person data and add cohort column
#' @description This function reads in a CSV file with candidate names and a CSV file with person data, and adds a "cohort" column to the person data based on whether each person's name is in the candidate name list.
#'
#' @param analysis_path The path to the folder containing the analysis data. If NULL, defaults to the "pooled/equated" folder in the current working directory.
#'
#' @return A data frame containing the person data with an added "cohort" column.
#'
#' @keywords internal
read_persons_csv <- function(analysis_path = NULL) {
  # If analysis_path is NULL, set it to the pooled/equated folder in the current working directory
  if (is.null(analysis_path)) {
    analysis_path = fs::path_wd("pooled/equated")
  }

  # Read in the candidate names CSV file and generate a list of candidate IDs
  can_names = read.csv(fs::dir_ls(analysis_path, glob = "*_names.csv"))
  can_list <- add_lead(cannames$CandidateID,width = 7) %>% as.list()

  # Read in the person data CSV file and add a cohort column based on whether each person's name is in the candidate name list
  facet1 = read.csv(fs::dir_ls(analysis_path, glob = "*PERSONS_Total.csv"), skip = 1)
  facet1$NAME <- add_lead(facet1$NAME, width = 7)
  facet1$cohort <- 0
  facet1$cohort[facet1$NAME %in% can_list] <- 1

  return(facet1)
}

#' @title Read item data and compute P-value
#' @description This function reads in a CSV file with item data and computes the P-value for each item. The function can read in item data from either the pooled/equated folder or the reanchored folder, depending on the value of the cohort_analysis parameter.
#'
#' @param analysis_path The path to the folder containing the analysis data. If NULL, defaults to the "pooled/equated" folder in the current working directory.
#' @param cohort_analysis Logical. If TRUE (default), reads in item data from the reanchored folder. If FALSE, reads in item data from the pooled/equated folder.
#'
#' @return A data frame containing the item data with an added "PVALUE" column.
#'
#' @keywords internal
read_items_csv <- function(analysis_path = NULL, cohort_analysis = TRUE) {
  # If analysis_path is NULL, set it to the pooled/equated folder in the current working directory
  if (is.null(analysis_path)) {
    analysis_path = fs::path_wd("pooled/equated")
    msg = glue::glue("Analysis path defaulted to \n{analysis_path}")
    message(msg)
  }

  # Read in the item data CSV file and compute P-value for each item
  if (cohort_analysis == FALSE) {
    facet2 = read.csv(fs::dir_ls(analysis_path, glob = "*ITEMS_Total.csv"), skip = 1)
  } else {
    facet2 = read.csv(fs::dir_ls(fs::path(analysis_path, "Reanchored"), glob = "*ITEMS*"), skip = 1)
  }
  facet2$PVALUE <- facet2$SCORE / facet2$COUNT

  return(facet2)
}
#' Count the number of 0s and 1s in the cohort vector and confirm with the user
#'
#' This function counts the number of 0s and 1s in the `cohort` vector of a data frame called `facet1`, and prompts the user to confirm whether the counts are correct using the `ui_yeah` function from the `usethis` package.
#' @param facet1 A data frame containing a `cohort` column.
#'
#' @keywords internal
#'
#' @importFrom usethis ui_yeah ui_oops ui_done

cohort_count <- function(facet1) {
  # Count the number of 0s and 1s in the cohort vector
  numZeros <- sum(facet1$cohort == 0)
  numOnes <- sum(facet1$cohort == 1)

  # Prompt the user to confirm whether the counts are correct
  conf <- usethis::ui_yeah(
    x ="Number of candidates:\nCurrent Cohort: {numOnes}\nHistorical Candidates Pooled: {numZeros}",
    yes =c("YES","YEP"),no =c("no", "nope"),
    n_yes = 1, n_no = 2
  )
  if (!conf) {
    usethis::ui_oops("Counts are incorrect. Please check the data and try again.")
  }else{
    usethis::ui_done("Cohort count correct!")
  }
}

#' @keywords internal
count_pass_fail <- function(facet1, cut_logit) {
  # Compute PASS/FAIL results based on MEASURE and cut_logit
  pass_fail <- ifelse(
    round.up(
      facet1$MEASURE >= cut_logit,2), "PASS", "FAIL")

  # Count the number of PASS/FAIL results among rows where cohort == 1
  pass_count <- sum(facet1$cohort == 1 & pass_fail == "PASS")
  fail_count <- sum(facet1$cohort == 1 & pass_fail == "FAIL")

  conf <- usethis::ui_yeah(
    x ="Pass and fail breakdown for cohort candidates\nFor a logit cut score of {cut_logit}:
  \n{pass_count} passing candidates\n{fail_count} failing candidates\n
  Is this correct??",
    yes =c("YES","YEP"),no =c("no", "nope"),
    n_yes = 1, n_no = 2
  )
  # Prompt the user with the counts using ui_* functions from the usethis package
  if (!conf) {
    usethis::ui_oops("Pass-fail counts are incorrect. Please check the data and try again.")
  }else{
    usethis::ui_done("Pass-fail count correct!")
  }
}
