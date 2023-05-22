#' Initial Information Extraction for Present Exam
#'
#' This function extracts initial information from the present exam data.
#' The data should be in a directory named 'Hobbes Original' within the working directory.
#' The information extracted includes the exam code, cohort size, the number of items per form,
#' the number of response options, and the response option codes.
#'
#' @param hobbes_in_wd A string specifying the directory in the working directory where the hobbes files are stored. Default is NULL.
#' @return A list named 'exam_info' with the following elements:
#'  - 'exam_code': The name of the current working directory, which should be the exam code.
#'  - 'cohort_n': The number of rows in the pre-scored data, which should be the cohort size.
#'  - 'nitms_form': The number of columns minus 1 in the pre-scored data, which should be the number of items per form.
#'  - 'n_opts': The number of unique response options in the domain key.
#'  - 'i_opts': Number of distinct options.
#'  - 'codes': A string of response option codes. If there are more than 5, a warning is printed.
#'
#' @examples
#' \dontrun{
#' exam_info = info_exam_beta()
#' }
#' @export
info_exam_beta <- function(create_exam_dir = TRUE) {
  remote_dir = usethis::ui_code_block(copy = FALSE,.envir = rlang::current_env(),
                         x = c("We'll be selecting the exam folder and copying it locally", "If you'd like to do a remote scoring, contact christopher.","After copying the exam_folder locally, We'll collect some information about the exam\n to facilitate the scoring process.")

  dir1 = fs::path("Z:/Psychometrics/Scoring")
if(fs::dir_exists(dir1))
   dir1 = fs::path("N:/Psychometrics/Scoring")

  if (isTRUE(create_exam_dir)) {
    message("Let's choose the exam and copy it locally")
    remote_dir = rstudioapi::selectFile(caption = "Choose exam root folder to create locally",label = "Choose.",path = )
    local_dir = fs::dir_create(remote_dir,recurse = FALSE)
    message("This is your new root, working directory")
    fs::dir_create(fs::path_wd("_revision_tracker"),recurse = FALSE)

    usethis::create_project(local_dir,rstudio = TRUE,open = FALSE)
    invisible(setwd(localdir))
    fs::fs::dir_ls(fs::path_wd())


  # Find directory containing "obbes" in the name in the working directory
  hobbes = fs::dir_ls(fs::path_wd(),glob = "*obbes*",type = "directory")

  # Get the name of the current working directory, which should be the exam code
  exam_code =  fs::path_file(fs::path_wd())

  # Display a red box with the exam code
  #box_red <- cli::boxx(exam_code, padding = 3, background_col = "bg_red")

  # Read in the pre-scored data
  prescored <- fs::dir_ls(fs::path_wd("Hobbes Original"),
                          type = "file",
                          glob = "*SCORED*") %>%
    read.csv()

  # Get the cohort size (number of rows in the pre-scored data)
  cohort_n <- prescored %>% nrow()

  # Assign "pooled" if cohort size is less than 30, otherwise "unpooled"
  ifelse(cohort_n < 30, "pooled" = TRUE, "unpooled" = FALSE)

  # Get the number of items per form (number of columns minus 1 in the pre-scored data)
  nitms_form <- prescored %>% ncol() - 1

  # Read in the domain key and get the number of unique response options
  n_opts = read.csv("Hobbes Original/Domain Key.csv") %>%
    dplyr::select(KEY) %>%  unique() %>% nrow

  # Define the response option codes (LETTERS[1:n_opts] concatenated with "-")
  codes = paste0(collapse = "",c("CODES = ",LETTERS[1:n_opts],"-"))
  # Print a warning if there are more than 5 response options
  if(n_opts > 5){
    cat(codes,"used much later")
  }

  # Create a tibble named 'exam_info' with the extracted information
  exam_info = tibble::lst(exam_code = exam_code, cohort_n = cohort_n, nitms_form = nitms_form, n_opts = n_opts, codes = codes, analysis_file = remote_dir)



  return(exam_info)
  }else{
  message("If your analysis folder is structered with hobbes in the main folder, choose the path to that folder.")
    local_dir = rstudioapi::selectFile(caption = "Choose path to analysis folder (should be named == exam_code)",label = "choose",path = fs::path_home_r())
    # Print a warning message
    message("dunno now")
    exam_info = rlang::list2(exam_code = exam_code, cohort_n = cohort_n, nitms_form = nitms_form, n_opts = n_opts, codes = codes)
  }
}
