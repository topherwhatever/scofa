### NOTE: GET THE REST OF THIS FROM PERSONAL COMPUTER

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
begin_examcode_old <- function(...) {
  require(fs)
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
