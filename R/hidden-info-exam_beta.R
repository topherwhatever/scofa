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
info_exam_beta <- function(hobbes_in_wd = NULL ) {

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
  ifelse(cohort_n < 30, "pooled", "unpooled")

  # Get the number of items per form (number of columns minus 1 in the pre-scored data)
  nitms_form <- prescored %>% ncol() - 1

  # Read in the domain key and get the number of unique response options
  n_opts = read.csv("Hobbes Original/Domain Key.csv") %>%
    dplyr::select(KEY) %>%  unique() %>% nrow

  # Define the response option codes (LETTERS[1:n_opts] concatenated with "-")
  codes = paste0(collapse = "",c("CODES = ",LETTERS[1:n_opts],"-"))
  # Print a warning if there are more than 5 response options
  if(n_opts > 5){
    cat(codes,"but I wouldn't trust it")
  }

  # Create a tibble named 'exam_info' with the extracted information
  exam_info = tibble::lst(exam_code = exam_code, cohort_n = cohort_n, nitms_form = nitms_form, n_opts = n_opts, codes = codes)

  # Print a warning message
  message("dunno yet")

  return(exam_info)
}
