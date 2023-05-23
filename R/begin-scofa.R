### NOTE: GET THE REST OF THIS FROM PERSONAL COMPUTER

#' Starting an Analysis
#'
#' @param ,,, either empty for inserting the path to your exam folder, or if your exam folder is your working directoy, leave empty
#'
#' @return creates a directory set in your working directory and a list object with paths to important directories
#' @export
#'
#' @examples
#' begin_examcode_providers("NONEXAM")
begin_examcode_priorvers <- function(...) {
  require(fs)
  exam_code = "string with exam_code"
  rlang::used
  exam_code = fs::path_wd() %>% path_file()
  exam_code <<- exam_code
}
#
#   setMethod("scofa_begin", "exam_info", function(x) x@exam_info)
#   setMethod("age<-", "Person", function(x, hobbes_in_wd) {
#     exam_info=list(x@age <- value)
#     exam_info
#   })
#
#   #
# }
